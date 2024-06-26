import Foundation

public extension Int {

    var formatedUsingAbbrevation: String {
        let numFormatter = NumberFormatter()

        typealias Abbrevation = (threshold: Double, divisor: Double, suffix: String)
        let abbreviations: [Abbrevation] = [
            (0, 1, ""),
            (1_000.0, 1_000.0, "K"),
            (999_999.0, 1_000_000.0, "M"),
            (999_999_999.0, 1_000_000_000.0, "B"),
        ]

        let startValue = Double(abs(self))
        let abbreviation: Abbrevation = {
            var prevAbbreviation = abbreviations[0]
            for tmpAbbreviation in abbreviations {
                if startValue < tmpAbbreviation.threshold {
                    break
                }
                prevAbbreviation = tmpAbbreviation
            }
            return prevAbbreviation
        }()

        let value = Double(self)/abbreviation.divisor

        numFormatter.decimalSeparator = "."
        numFormatter.positiveSuffix = abbreviation.suffix
        numFormatter.negativeSuffix = abbreviation.suffix
        numFormatter.allowsFloats = true
        numFormatter.minimumIntegerDigits = 1
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 1
        numFormatter.locale = .current

        return numFormatter.string(from: NSNumber(value: value)) ?? "N/A"
    }
}
