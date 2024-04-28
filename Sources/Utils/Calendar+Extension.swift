import Foundation

public extension Calendar {

    var monthStart: Date? {
        dateInterval(of: .month, for: .now)?.start.toLocalTime()
    }

    var monthEnd: Date? {
        dateInterval(of: .month, for: .now)?.end.toLocalTime(secondsCorrection: 1)
    }

    var thisWeekFirstDay: Date? {
        date(from: dateComponents([.yearForWeekOfYear, .weekOfYear], from: .now))?.toLocalTime()
    }

    var thisWeekLastDay: Date? {
        guard let thisWeekFirstDay else { return nil }
        return date(byAdding: .day, value: 6, to: thisWeekFirstDay)?
            .toLocalTime(secondsCorrection: 1)
    }

    func adjustDays(_ days: Int, to date: Date) -> Date? {
        var dateComponent = DateComponents()
        dateComponent.day = days
        return self.date(byAdding: dateComponent, to: date)
    }

    func yearStart(_ year: Int) -> Date? {
        dateInterval(of: .year, for: Date.getDate(day: 1, month: 1, year: year))?
            .start.toLocalTime()
    }

    func yearEnd(_ year: Int) -> Date? {
        dateInterval(of: .year, for: Date.getDate(day: 1, month: 1, year: year))?
            .end.toLocalTime()
    }
}

private extension Date {

    func toLocalTime(secondsCorrection: Double = 0) -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds - secondsCorrection, since: self)
    }
}
