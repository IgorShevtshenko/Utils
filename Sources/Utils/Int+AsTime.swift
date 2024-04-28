import Foundation

public extension Int {

    func asTime(
        in style: DateComponentsFormatter.UnitsStyle,
        allowedUnits: NSCalendar.Unit
    ) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = allowedUnits
        formatter.unitsStyle = style
        return formatter.string(from: TimeInterval(self * 60))
    }
}
