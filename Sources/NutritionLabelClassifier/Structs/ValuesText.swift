import VisionSugar
import CoreGraphics

struct ValuesText {

    var values: [Value]
    let text: RecognizedText
    
    init?(_ text: RecognizedText) {
        let values = Value.detect(in: text.string)
        guard values.count > 0 else {
            return nil
        }        
        self.text = text
        
        /// Previously—if only value has a unit, pick that one and discard the rest
        if let singleValue = values.singleValueAfterRemovingPercentageValues {
            self.values = [singleValue]
        } else
        if values.containingUnit.count == 1 {
            self.values = values.containingUnit
        } else {
            self.values = values
        }
        
        /// Remove all values with a percent
//        values.removeAll(where: { $0.unit == .p })
        
        /// If there are values with units—remove all that don't have any
//        if values.contains(where: { $0.unit != nil }) {
//            values.removeAll(where: { $0.unit == nil })
//        }
        
//        self.values = values
    }
    
    init(values: [Value], text: RecognizedText = defaultText) {
        self.values = values
        self.text = text
    }

    var containsValueWithEnergyUnit: Bool {
        values.containsValueWithEnergyUnit
    }
    
    var containsEnergyDisqualifyingTexts: Bool {
        text.string.lowercased().contains("based on a")
    }
    
    var containsNutrientUnit: Bool {
        values.containsValueWithNutrientUnit
    }
        
    var containsReferenceEnergyValue: Bool {
        values.containsReferenceEnergyValue
    }
    
    var containsValueWithKjUnit: Bool {
        values.containsValueWithKjUnit
    }

    var containsValueWithKcalUnit: Bool {
        values.containsValueWithKcalUnit
    }

    func closestAttributeText(in attributeTexts: [AttributeText]) -> AttributeText? {
        attributeTexts.sorted(by: {
//            return $0.yDistanceTo(valuesText: self) < $1.yDistanceTo(valuesText: self)
            

            let inlineRatio1 = text.rect.ratioThatIsInline(with: $0.allTextsRect) ?? 0
            let inlineRatio2 = text.rect.ratioThatIsInline(with: $1.allTextsRect) ?? 0
            print("6️⃣ Checking: \($0.attribute.rawValue) (\(inlineRatio1)) and \($1.attribute.rawValue) (\(inlineRatio2))")
            
            /// The more the `text` intersects with an `attributeText`—the more `inline` it is with it
            guard inlineRatio1 > inlineRatio2 else {
                return false
            }

            print("6️⃣    Further checking inlineHeights: \(inlineRatio1) and \(inlineRatio2)")
            let inlineHeight1 = text.rect.heightThatIsInline(with: $0.allTextsRect) ?? 0
            let inlineHeight2 = text.rect.heightThatIsInline(with: $1.allTextsRect) ?? 0
            
            let difference = abs(inlineHeight1-inlineHeight2)
            let differenceRatio = difference / (inlineHeight1 > inlineHeight2 ? inlineHeight1 : inlineHeight2)
            
            /// If the difference between the two inline heights is less than 5%, use the other heuristic of the distance from the mid point of `text` to the `minY` or `maxY` of the `AttributeText`, depending on which one is on top.
            guard differenceRatio > 0.25 else {

                /// Since $0 is always below $1, we use its minY
                let distance1 = abs(text.rect.midY - $0.allTextsRect.minY)
                /// Since $1 is always above $0, we use its maxY
                let distance2 = abs(text.rect.midY - $1.allTextsRect.maxY)
                return distance1 < distance2

            }
            
            return true
            
        }).first
    }
    
    var isSingularPercentValue: Bool {
        if values.count == 1, let first = values.first, first.unit == .p {
            return true
        }
        return false
    }
    
    var isSingularNutritionUnitValue: Bool {
        
        values.filter {
            $0.unit?.isNutrientUnit == true
        }.count == 1
        
//        if values.count == 1, let first = values.first, let unit = first.unit, unit.isNutrientUnit {
//            return true
//        }
//
//        return false
    }
    
    var alternateValues: [Value] {
        var values: [Value] = []
        for string in text.candidates {
            values.append(contentsOf: Value.detect(in: string))
        }
        return values
    }
}

extension NutritionUnit {
    var isNutrientUnit: Bool {
        switch self {
        case .mcg, .mg, .g:
            return true
        default:
            return false
        }
    }
}

extension ValuesText: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(values)
        hasher.combine(text)
    }
}

extension Array where Element == ValuesText {
    var containsValueWithEnergyUnit: Bool {
        contains(where: { $0.containsValueWithEnergyUnit })
    }
    
    var containsReferenceEnergyValue: Bool {
        contains { $0.containsReferenceEnergyValue }
    }
    var containsServingAttribute: Bool {
        contains(where: { $0.text.containsServingAttribute })
    }
    
    var kjValues: [ValuesText] {
        filter({ $0.containsValueWithKjUnit })
    }
    
    var kcalValues: [ValuesText] {
        filter({ $0.containsValueWithKcalUnit })
    }
    
    func closestValueText(to attributeText: AttributeText, in attributes: [AttributeText]? = nil, requiringOverlap: Bool = false) -> ValuesText? {
        let sorted = self.sorted(by: {
            attributeText.yDistanceTo(valuesText: $0) < attributeText.yDistanceTo(valuesText: $1)
//            $0.text.rect.yDistanceToTopOf(text.rect) < $1.text.rect.yDistanceToTopOf(text.rect)
        })
        
        guard let closest = sorted.first else {
            return nil
        }
        
        /// If attributes were provided—make sure that there isn't another attribute closer to this `ValueText`
        if let attributes = attributes {
            guard let closestAttribute = closest.closestAttributeText(in: attributes),
                  closestAttribute.attribute == attributeText.attribute else {
                return nil
            }
        }
        
        guard requiringOverlap else {
            return closest
        }
        
        if let _ = closest.text.rect
            .rectWithXValues(of: attributeText.allTextsRect)
            .ratioOfIntersection(with: attributeText.allTextsRect)
        {
            return closest
        } else {
            return nil
        }
    }
    
    var rect: CGRect {
        guard let first = self.first else { return .zero }
        var unionRect = first.text.rect
        for valuesText in self.dropFirst() {
            unionRect = unionRect.union(valuesText.text.rect)
        }
        return unionRect
//        reduce(.zero) {
//            $0.union($1.text.rect)
//        }
    }
}

extension CGRect {
    func yDistanceToTopOf(_ rect: CGRect) -> CGFloat {
        abs(midY - rect.minY)
    }
}

//extension CGPoint {
//    func distanceSquared(to: CGPoint) -> CGFloat {
//        (self.x - to.x) * (self.x - to.x) + (self.y - to.y) * (self.y - to.y)
//    }
//
//    func distance(to: CGPoint) -> CGFloat {
//        sqrt(CGPointDistanceSquared(from: from, to: to))
//    }
//}
