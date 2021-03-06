import SwiftUI
import VisionSugar

struct ExtractedValues {
    
    let groupedColumns: [[ValuesTextColumn]]
    
    init(visionResult: VisionResult, extractedAttributes: ExtractedAttributes) {
        
        var columns: [ValuesTextColumn] = []
        
        let start = CFAbsoluteTimeGetCurrent()
        
        for recognizedTexts in [visionResult.accurateRecognitionWithLanugageCorrection ?? []] {
            for text in recognizedTexts {

                print("1️⃣ Getting ValuesTextColumn starting from: '\(text.string)'")

                guard !text.containsServingAttribute else {
                    print("1️⃣   ↪️ Contains serving attribute")
                    continue
                }
                
                guard !text.containsHeaderAttribute else {
                    print("1️⃣   ↪️ Contains header attribute")
                    continue
                }
                
                guard let column = ValuesTextColumn(startingFrom: text, in: visionResult) else {
                    print("1️⃣   Did not get a ValuesTextColumn")
                    continue
                }
                
                print("1️⃣   Got a ValuesTextColumn with: \(column.valuesTexts.count) valuesTexts")
                print("1️⃣   \(column.desc)")
                columns.append(column)
            }
        }

        print("⏱ extracting columns took: \(CFAbsoluteTimeGetCurrent()-start)s")

        let groupedColumns = Self.process(valuesTextColumns: columns,
                                          attributes: extractedAttributes,
                                          using: visionResult)
        self.groupedColumns = groupedColumns
    }
    
    static func process(valuesTextColumns: [ValuesTextColumn], attributes: ExtractedAttributes, using visionResult: VisionResult) -> [[ValuesTextColumn]] {

        let start = CFAbsoluteTimeGetCurrent()

        var columns = valuesTextColumns

        columns.removeTextsAboveEnergy(for: attributes)
        columns.removeTextsAboveHeader(from: visionResult)
        columns.removeTextsBelowLastAttribute(of: attributes)
        columns.removeTextsWithMultipleNutrientValues()
        columns.removeTextsWithExtraLargeValues()
        columns.removeTextsWithHeaderAttributes()

        columns.removeDuplicateColumns()
        columns.removeEmptyColumns()
        columns.removeColumnsWithSingleValuesNotInColumnWithAllOtherSingleValues()
        columns.removeExtraLongFooterValuesWithNoAttributes(for: attributes)
        columns.removeInvalidColumns()
        columns.pickTopColumns(using: attributes)
        columns.removeColumnsWithServingAttributes()

        columns.removeColumnsWithNoValuesPastFirstAttributesColumn(in: attributes)
        
        columns.sort()
        columns.removeSubsetColumns()
        columns.splitUpColumnsWithAllMultiColumnedValues()
        columns.cleanupEnergyValues(using: attributes)

        columns.removeOverlappingTextsWithSameString()
        columns.removeFullyOverlappingTexts()

        columns.removeReferenceColumns()
        
        var groupedColumns = groupByAttributes(columns, attributes: attributes)
        groupedColumns.removeColumnsInSameColumnAsAttributes(in: attributes)
        groupedColumns.removeExtraneousColumns()
//        groupedColumns.removeInvalidValueTexts()
         print("⏱ processing columns took: \(CFAbsoluteTimeGetCurrent()-start)s")
        return groupedColumns
    }

    /// - Group columns if `attributeTextColumns.count > 1`
    static func groupByAttributes(_ initialColumnsOfTexts: [ValuesTextColumn], attributes: ExtractedAttributes) -> [[ValuesTextColumn]] {
        
        let attributeColumns = attributes.attributeTextColumns
        guard attributeColumns.count > 1 else {
            return [initialColumnsOfTexts]
        }
        
        var columnsOfTexts = initialColumnsOfTexts
        var groups: [[ValuesTextColumn]] = []

        /// For each Attribute Column
        for i in attributeColumns.indices {
            let attributeColumn = attributeColumns[i]

            /// Get the minX of the shortest attribute
            guard let attributeColumnMinX = attributeColumn.shortestText?.rect.minX else { continue }

            var group: [ValuesTextColumn] = []
            while group.count < 2 && !columnsOfTexts.isEmpty {
                let column = columnsOfTexts.removeFirst()

                /// Skip columns that are clearly to the left of this `attributeTextColumn`
                guard let columnMaxX = column.shortestText?.rect.maxX,
                      columnMaxX > attributeColumnMinX else {
                    continue
                }

                /// If we have another attribute column
                if i < attributeColumns.count - 1 {
                    /// If we have reached columns that is to the right of it
                    guard let nextAttributeColumnMinX = attributeColumns[i+1].shortestText?.rect.minX,
                          columnMaxX < nextAttributeColumnMinX else
                    {
                        /// Make sure we re-insert the column so that it's extracted by that column
                        columnsOfTexts.insert(column, at: 0)

                        /// Stop the loop so that the next attribute column is focused on
                        break
                    }
                }

                group.append(column)

                /// Skip columns that contain all nutrient attributes
//                guard !column.allElementsContainNutrientAttributes else {
//                    continue
//                }

                /// Skip columns that contain all percentage values
//                guard !column.allElementsArePercentageValues else {
//                    continue
//                }

                //TODO: Write this
                /// If this column has more elements than the existing (first) column and contains any texts belonging to it, replace it
//                if let existing = group.first,
//                    column.count > existing.count,
//                    column.containsTextsFrom(existing)
//                {
//                    group[0] = column
//                } else {
//                    group.append(column)
//                }
            }

            groups.append(group)
        }

        return groups
        
//        return [initialColumnsOfTexts]
    }
}

extension Array where Element == [ValuesTextColumn] {
    var desc: [[String]] {
        map { $0.desc }
    }
    
    mutating func removeExtraneousColumns() {
        for i in indices {
            let group = self[i]
            guard group.count > 2 else { continue }
            self[i] = group.enumerated().compactMap{ $0.offset < 2 ? $0.element : nil }
        }
    }
    
    mutating func removeColumnsInSameColumnAsAttributes(in extractedAttributes: ExtractedAttributes) {
        /// If there's only column, don't consider this heuristic
        guard totalColumnsCount != 1 else {
            return
        }
        for i in indices {
            guard i < extractedAttributes.attributeTextColumns.count else { continue }
            let attributesRect = extractedAttributes.attributeTextColumns[i].rect
            self[i] = self[i].filter { $0.rect.maxX > attributesRect.maxX }
        }
    }
    
    var totalColumnsCount: Int {
        reduce(0) { $0 + $1.count }
    }
}

extension ValuesTextColumn {
    
    mutating func pickEnergyValueIfMultiplesWithinText(energyPairIndexToExtract index: inout Int, lastMultipleEnergyTextId: inout UUID?) {
        
        for i in valuesTexts.indices {
            let valuesText = valuesTexts[i]
            guard valuesText.containsMultipleEnergyValues else {
                continue
            }
            
            /// If we've encountered a different text to the last one, reset the `energyPairIndexToExtract` variable
            if let textId = lastMultipleEnergyTextId, textId != valuesText.text.id {
                index = 0
            }
            lastMultipleEnergyTextId = valuesTexts[i].text.id
            
            valuesTexts[i].pickEnergyValue(energyPairIndexToExtract: &index)
            break
        }
    }
}

typealias EnergyPair = (kj: Value?, kcal: Value?)

extension Array where Element == Value {

    var energyPairs: [EnergyPair] {
        var pairs: [EnergyPair] = []
        var currentPair = EnergyPair(kj: nil, kcal: nil)
        for value in self {
            if value.unit == .kj {
                guard currentPair.kj == nil else {
                    pairs.append(currentPair)
                    currentPair = EnergyPair(kj: value, kcal: nil)
                    continue
                }
                currentPair.kj = value
            }
            else if value.unit == .kcal {
                guard currentPair.kcal == nil else {
                    pairs.append(currentPair)
                    currentPair = EnergyPair(kj: nil, kcal: value)
                    continue
                }
                currentPair.kcal = value
            }
        }
        pairs.append(currentPair)
        return pairs
    }
}

extension ValuesText {
    
    mutating func pickEnergyValue(energyPairIndexToExtract: inout Int) {
        let energyPairs = values.energyPairs

        guard energyPairIndexToExtract < energyPairs.count else {
            return
        }
        let energyPair = energyPairs[energyPairIndexToExtract]
        energyPairIndexToExtract += 1
        
        //TODO: Make this configurable
        /// We're selecting kj here preferentially
        guard let kj = energyPair.kj else {
            guard let kcal = energyPair.kcal else {
                return
            }
            values = [kcal]
            return
        }
        values = [kj]
    }
    
    var containsMultipleEnergyValues: Bool {
        values.filter({ $0.hasEnergyUnit }).count > 1
    }
}

extension ValuesTextColumn {
    /// Returns true if this column is a subset of a column (ie. containing all the elements in the same order, but with a fewer count) than any of the columns in the provided array
    func isSubsetOfColumn(in array: [ValuesTextColumn]) -> Bool {
        array.contains { isSubset(of: $0) }
    }

    func isSubset_legacy(of column: ValuesTextColumn) -> Bool {
        guard valuesTexts.count < column.valuesTexts.count else {
            return false
        }
        
        let set = Set(valuesTexts)
        let columnSet = Set(column.valuesTexts)
        return set.isSubset(of: columnSet)
//        let allElemtsEqual = findListSet.isSubsetOfSet(otherSet: listSet)
    }
    
    func isSubset(of column: ValuesTextColumn) -> Bool {
        /// If the `valuesTexts` array is not less than the column's one, or we have no elements in this array, or we're unable to find the first element in the column's array, return false immediately.
        guard valuesTexts.count < column.valuesTexts.count,
              let first = valuesTexts.first,
              let startIndex = column.valuesTexts.firstIndex(of: first)
        else {
            return false
        }
        
        /// If the `valuesTexts` array has only 1 element and we've already found it, return `true`
        guard valuesTexts.count > 1 else { return true }
        
        /// For all the remaining `valuesTexts`
        for i in 1..<valuesTexts.count {
            let columnIndex = startIndex + i
            
            /// If the column's array doesn't have an element at the respective index (`i` elements after the `startIndex`), or that element doesn't match the element at `i` of this array, return false immediately.
            guard columnIndex < column.valuesTexts.count,
                  valuesTexts[i] == column.valuesTexts[columnIndex] else {
                return false
            }
        }
        
        /// If the remaining `valueTexts` passed, return true
        return true
    }
}

extension Array where Element == ValuesTextColumn {

    mutating func insertNilForMissingValues() {
        /// Get the column with the largest size as the `referenceColumn`
        /// Now get all the columns excluding the `referenceColumn`, calling it `partialColumns`
        /// For each `partialColumn`
        ///     Get the deltas of the `midY` between each column
        ///     Go through these, comparing them to the deltas of the `midY` of the reference column
        ///     As soon as we determine an anomaly (ie. a value with a statistically significant different),
        ///         Use that to determine the an index missing a value and add it to the array
        ///     After going through all the deltas and determining the empty columns
        ///         Fill them up with `nil` so that they can be determined later via scaling
    }
    
    var hasMismatchingColumnSizes: Bool {
        guard let firstColumnSize = first?.valuesTexts.count else {
            return false
        }
        for column in self.dropFirst() {
            if column.valuesTexts.count != firstColumnSize {
                return true
            }
        }
        return false
    }
    
    mutating func splitUpColumnsWithAllMultiColumnedValues() {
        for i in indices {
            let column = self[i]
            guard let splitColumns = column.splitUpColumnsUsingMultiColumnedValues else {
                continue
            }
            self[i] = splitColumns.0
            self.insert(splitColumns.1, at: i + 1)
        }
    }
    
    mutating func cleanupEnergyValues(using extractedAttributes: ExtractedAttributes) {
        /// If we've got any two sets of energy values (ie. two kcal and/or two kJ values), pick those that that are closer to the energy attribute
        let energyAttribute = extractedAttributes.energyAttributeText
        var extractedEnergyPairs = 0
        var lastMultipleEnergyTextId: UUID? = nil
        for i in indices {
            var column = self[i]
            column.pickEnergyValueIfMultiplesWithinText(energyPairIndexToExtract: &extractedEnergyPairs, lastMultipleEnergyTextId: &lastMultipleEnergyTextId)
            column.removeDuplicateEnergy(using: energyAttribute)
            column.pickEnergyIfMultiplePresent()
            self[i] = column
        }
    }

    mutating func removeExtraLongFooterValuesWithNoAttributes(for attributes: ExtractedAttributes) {
        for i in indices {
            var column = self[i]
            column.removeExtraLongFooterValuesWithNoAttributes(for: attributes)
            self[i] = column
        }
    }
    

    mutating func removeColumnsWithServingAttributes() {
        removeAll { $0.containsServingAttribute }
    }
    
    mutating func removeColumnsWithNoValuesPastFirstAttributesColumn(in attributes: ExtractedAttributes) {
        guard let attributesRect = attributes.columnRects.first else {
            return
        }

        removeAll {
            $0.valuesTexts.filter { valuesText in
                let valuesTextRect = valuesText.text.rect
                let attributesRect = attributesRect
                
                let thresholdPercentage = 0.05
                let distance = valuesTextRect.maxX - attributesRect.maxX
                return distance / attributesRect.width >= thresholdPercentage
            }.isEmpty
        }
    }
    
    mutating func removeColumnsWithSingleValuesNotInColumnWithAllOtherSingleValues() {
        removeAll {
//            $0.portionOfSingleValuesThatAreInColumnWithOtherSingleValues != 1.0
            
            if $0.valuesTexts.count == 2 {
                guard let ratio = $0.valuesTexts[0].text.rect
                    .ratioOfXIntersection(with: $0.valuesTexts[1].text.rect) else {
                    return false
                }
                return ratio > 0
            } else {
                
                if $0.valuesTexts.count == 3,
                   $0.singleValuesTexts.count == 1 {
                    return true
                }
                
                return $0.containsMoreThanOneSingleValue
                &&
                $0.portionOfSingleValuesThatAreInColumnWithOtherSingleValues != 1.0
            }
        }
        
    }
    
    var topMostEnergyValueTextUsingValueUnits: ValuesText? {
        var top: ValuesText? = nil
        for column in self {
            guard let index = column.indexOfFirstEnergyValue else { continue }
            guard let topValuesText = top else {
                top = column.valuesTexts[index]
                continue
            }
            if column.valuesTexts[index].text.rect.minY < topValuesText.text.rect.minY {
                top = column.valuesTexts[index]
            }
        }
        return top
    }
    
    func topMostEnergyValueTextUsingEnergyAttribute(from attributes: ExtractedAttributes) -> ValuesText? {
        guard let energyAttribute = attributes.attributeText(for: .energy) else {
            return nil
        }
        return topMostInlineValuesText(to: energyAttribute.text)
    }
    
    func topMostInlineValuesText(to text: RecognizedText) -> ValuesText? {
        var top: ValuesText? = nil
        for column in self {
            guard let topMostInlineValuesText = column.topMostInlineValuesText(to: text) else {
                continue
            }
            guard let topValuesText = top else {
                top = topMostInlineValuesText
                continue
            }
            if topMostInlineValuesText.text.rect.minY < topValuesText.text.rect.minY {
                top = topMostInlineValuesText
            }
        }
        return top
    }
    
    func topMostEnergyValueText(for attributes: ExtractedAttributes) -> ValuesText? {
        if let top = topMostEnergyValueTextUsingValueUnits {
            return top
        }
        /// If we still haven't got the top-most energy value, use the Energy attribute to find the-most value that is inline with it
        if let top = topMostEnergyValueTextUsingEnergyAttribute(from: attributes) {
            return top
        }
        return nil
    }
    
    mutating func removeOverlappingTextsWithSameString() {
        for i in indices {
            var column = self[i]
            column.removeOverlappingTextsWithSameString()
            self[i] = column
        }
    }
    
    mutating func removeFullyOverlappingTexts() {
        for i in indices {
            var column = self[i]
            column.removeFullyOverlappingTexts()
            self[i] = column
        }
    }
    
    mutating func removeReferenceColumns() {
        removeAll { $0.valuesTexts.containsReferenceEnergyValue }
    }

    mutating func removeTextsAboveEnergy(for attributes: ExtractedAttributes) {
        guard let energyText = topMostEnergyValueText(for: attributes)?.text else {
            return
        }
        
        print("7️⃣ \(energyText.string)")
        removeTextsAbove(energyText)
    }
    
    mutating func removeTextsAboveHeader(from visionResult: VisionResult) {
        guard let array = visionResult.accurateRecognitionWithLanugageCorrection else {
            return
        }
        for text in array {
            if text.string.matchesRegex("(supplement|nutrition) facts") {
                removeTextsAbove(text)
                return
            }
        }
    }
    
    mutating func removeTextsAbove(_ text: RecognizedText) {
        for i in indices {
            var column = self[i]
            column.removeValueTextsAbove(text)
            self[i] = column
        }
    }
    
    mutating func removeSubsetColumns() {
        /// Remove all columns that are subset of other columns
        let selfCopy = self
        removeAll { $0.isSubsetOfColumn(in: selfCopy) }
    }
    
    mutating func removeFirstColumnIfItSpansPastSecondColumn() {
        guard count == 2 else { return }
        let threshold = 0.0
        if self[0].columnRect.maxX - self[1].columnRect.maxX > threshold {
            self.remove(at: 0)
        }
    }
    
    mutating func removeFooterText(for attributes: ExtractedAttributes) {
        /// if we have a common text amongst all columns, and its maxY is past the maxY of the last attribute, remove it from all columns
        guard let valuesText = commonLastValuesText,
              let bottomAttributeText = attributes.bottomAttributeText,
              valuesText.text.rect.maxY > bottomAttributeText.text.rect.maxY else {
            return
        }
        
        for i in self.indices {
            var column = self[i]
            column.valuesTexts.removeLast()
            self[i] = column
        }
    }
    
    var commonLastValuesText: ValuesText? {
        var commonLastValuesText: ValuesText? = nil
        for column in self {
            guard let lastValuesText = column.valuesTexts.last else {
                continue
            }
            guard let currentValuesText = commonLastValuesText else {
                commonLastValuesText = lastValuesText
                continue
            }
            guard currentValuesText == lastValuesText else {
                return nil
            }
        }
        return commonLastValuesText
    }
    
    mutating func removeInvalidColumns() {
        guard let highestNumberOfRows = sorted(by: {
            $0.valuesTexts.count > $1.valuesTexts.count
        }).first?.valuesTexts.count else {
            return
        }
        
        /// Remove columns with too few rows
        if highestNumberOfRows > 1 {
            self = filter {
//                $0.valuesTexts.count > Int(ceil(0.1 * Double(highestNumberOfRows)))
                $0.valuesTexts.count > Int(ceil(0.15 * Double(highestNumberOfRows)))
            }
        }
        
        /// Remove columns that contain all attribute texts
        self = filter { column in
            column.valuesTexts.count > column.valuesTexts.filter { Attribute.detect(in: $0.text.string).count > 0 }.count
        }
        
        /// Remove columns that contain mostly attribute texts
//        self = filter { column in
//            let attributeTextsCount = column.valuesTexts.filter { Attribute.detect(in: $0.text.string).count > 0 }.count
//            let percentageOfAttributeTexts = Double(attributeTextsCount)/Double(column.valuesTexts.count)
//            return percentageOfAttributeTexts < 0.65
//        }

    }

    mutating func removeColumnsWithProportionallyLessValues() {
        guard let highestNumberOfRows = sorted(by: {
            $0.valuesTexts.count > $1.valuesTexts.count
        }).first?.valuesTexts.count else {
            return
        }
        
        /// Remove columns with too few rows
        self = filter {
//            $0.valuesTexts.count > Int(ceil(0.1 * Double(highestNumberOfRows)))
            $0.valuesTexts.count > Int(ceil(0.15 * Double(highestNumberOfRows)))
        }
        
//        /// Remove columns that contain all attribute texts
//        self = filter { column in
//            column.valuesTexts.count > column.valuesTexts.filter { Attribute.detect(in: $0.text.string).count > 0 }.count
//        }
    }

    mutating func removeTextsBelowLastAttribute(of extractedAttributes: ExtractedAttributes) {
        guard let bottomAttributeText = extractedAttributes.bottomAttributeText else {
            return
        }

        for i in self.indices {
            var column = self[i]
            column.removeValueTextsBelow(bottomAttributeText)
            self[i] = column
        }
    }

    mutating func removeTextsAboveFirstAttribute(of extractedAttributes: ExtractedAttributes) {
        guard let topAttributeText = extractedAttributes.topAttributeText else {
            return
        }

        for i in self.indices {
            var column = self[i]
            column.removeValueTextsAbove(topAttributeText)
            self[i] = column
        }
    }

    mutating func removeDuplicateColumns() {
        self = self.uniqued()
    }
    
    mutating func removeTextsWithMultipleNutrientValues() {
        for i in self.indices {
            var column = self[i]
            column.removeTextsWithMultipleNutrientValues()
            self[i] = column
        }
    }
    
    mutating func removeTextsWithExtraLargeValues() {
        for i in self.indices {
            var column = self[i]
            column.removeTextsWithExtraLargeValues()
            self[i] = column
        }
    }
    
    mutating func removeTextsWithHeaderAttributes() {
        for i in self.indices {
            var column = self[i]
            column.removeTextsWithHeaderAttributes()
            self[i] = column
        }
    }
    
    mutating func removeColumnsWithMultipleNutrientValues() {
        removeAll { column in
            column.valuesTexts.contains { valuesText in
                valuesText.values.filter { $0.hasNutrientUnit }.count > 3
            }
        }
    }
    
    mutating func removeEmptyColumns() {
        removeAll { $0.valuesTexts.count == 0 }
    }
    
    mutating func pickTopColumns(using attributes: ExtractedAttributes) {
        let groups = groupedColumnsOfTexts(for: attributes)
        self = Self.pickTopColumns(from: groups)
    }

    /// - Group columns based on their positions
    mutating func groupedColumnsOfTexts(for attributes: ExtractedAttributes) -> [[ValuesTextColumn]] {
        var groups: [[ValuesTextColumn]] = []
        for column in self {

            var didAdd = false
            for i in groups.indices {
                if column.belongsTo(groups[i], using: attributes) {
                    groups[i].append(column)
                    didAdd = true
                    break
                }
            }

            if !didAdd {
                groups.append([column])
            }
        }
        return groups
    }
    
    /// - Pick the column with the most elements in each group
    static func pickTopColumns(from groupedColumns: [[ValuesTextColumn]]) -> [ValuesTextColumn] {
        var topColumns: [ValuesTextColumn] = []
        for group in groupedColumns {
            guard let top = group.sorted(by: { $0.valuesTexts.count > $1.valuesTexts.count }).first else { continue }
            topColumns.append(top)
        }
        return topColumns
    }
    
    /// - Order columns
    ///     Compare `midX`'s of shortest text from each column
    mutating func sort() {
        sort(by: {
            guard let midX0 = $0.midXOfShortestText, let midX1 = $1.midXOfShortestText else {
                return false
            }
            return midX0 < midX1
        })
    }
}
