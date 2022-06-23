import VisionSugar

struct ValuesText {

    let values: [Value]
    let text: RecognizedText
    
    init?(_ text: RecognizedText) {
        let values = Value.detect(in: text.string)
        guard values.count > 0 else {
            return nil
        }        
        self.text = text
        self.values = values
    }

    var containsValueWithEnergyUnit: Bool {
        values.containsValueWithEnergyUnit
    }
    
    var isSingularPercentValue: Bool {
        if values.count == 1, let first = values.first, first.unit == .p {
            return true
        }
        return false
    }
    
    var isSingularNutritionUnitValue: Bool {
        if values.count == 1, let first = values.first, let unit = first.unit, unit.isNutrientUnit {
            return true
        }
        return false
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
    
    var containsServingAttribute: Bool {
        contains(where: { $0.text.containsServingAttribute })
    }
}
