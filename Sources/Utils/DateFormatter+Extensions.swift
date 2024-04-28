import Foundation

public extension DateFormatter {

    static var reviewUpdatetedAtDateFormater: DateFormatter = {
        let dateFormatter = DateFormatter()
        guard let timeZone = TimeZone(identifier: "UTC") else {
            fatalError("Can't find timezone with selected identifier")
        }
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }()

    static var movieadoPrimary: DateFormatter = {
        let dateFormatter = DateFormatter()
        guard let timeZone = TimeZone(identifier: "UTC") else {
            fatalError("Can't find timezone with selected identifier")
        }
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()

    static var yearDayDate: (Locale) -> DateFormatter = { locale in
        let dateFormatter = DateFormatter.yearDayDateFormatter
        dateFormatter.locale = locale
        return dateFormatter
    }

    static var birthDate: (Locale) -> DateFormatter = { locale in
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        formatter.locale = locale
        return formatter
    }

    private static var yearDayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }()
}
