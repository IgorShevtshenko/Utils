import Foundation

public extension String {

    func convertToDateWithTime() throws -> Date {
        if let date = DateFormatter.reviewUpdatetedAtDateFormater.date(from: self) {
            return date
        } else {
            assertionFailure("Could not format to date: \(self)")
            throw NSError(domain: "Could not format to date: \(self)", code: 0)
        }
    }

    func convertToDate() -> Date? {
        DateFormatter.movieadoPrimary.date(from: self)
    }
}
