import Foundation

public extension Double {

    func pretty(subText: String, ommitPrefix: Bool = false) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = " "
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = ","
        numberFormatter.alwaysShowsDecimalSeparator = false
        let isFractionDigitsAvailable = truncatingRemainder(dividingBy: 1) != 0
        numberFormatter.minimumFractionDigits = !isFractionDigitsAvailable ? 0 : 2
        numberFormatter.maximumFractionDigits = 2
        let absoluteNumber = NSNumber(value: fabs(self))
        guard let formattedString = numberFormatter.string(from: absoluteNumber) else {
            fatalError("Failed to format" + debugDescription)
        }
        let finalString = prefix(ommitPrefix: ommitPrefix) + formattedString + subText
        return finalString.condensedWhitespaces
    }

    private func prefix(ommitPrefix: Bool) -> String {
        sign == .minus
        ? "-" 
        : ommitPrefix ? "" : "+"
    }
}

private extension String {

    var condensedWhitespaces: String {
        split(separator: " ").joined(separator: " ")
    }
}
