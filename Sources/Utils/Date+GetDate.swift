import Foundation

public extension Date {

    static func getDate(
        day: Int,
        month: Int,
        year: Int,
        hour: Int = 0,
        minute: Int = 0,
        second: Int = 0
    ) -> Date {
        var dateComponent = DateComponents()
        dateComponent.day = day
        dateComponent.month = month
        dateComponent.year = year
        dateComponent.hour = hour
        dateComponent.minute = minute
        dateComponent.second = second
        guard let date = Calendar.current.date(from: dateComponent) else {
            fatalError("Can't get date from \(dateComponent)")
        }
        return date
    }
}
