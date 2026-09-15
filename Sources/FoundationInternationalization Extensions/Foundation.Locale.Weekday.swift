import Foundation

extension Locale.Weekday {

    /// The weekday as `Calendar` numbers it: Sunday is 1, Saturday 7; none for a weekday
    /// Foundation adds after these seven.
    public var number: Int? {
        switch self {
        case .sunday: 1
        case .monday: 2
        case .tuesday: 3
        case .wednesday: 4
        case .thursday: 5
        case .friday: 6
        case .saturday: 7
        @unknown default: nil
        }
    }
}

extension Calendar {

    /// The first instant of the next `weekday` strictly after the moment.
    public static func next(_ weekday: Locale.Weekday, after date: Date, in calendar: Calendar) -> Date? {
        weekday.number.flatMap { calendar.nextDate(after: date, matching: DateComponents(weekday: $0), matchingPolicy: .nextTime) }
    }

    public func next(_ weekday: Locale.Weekday, after date: Date) -> Date? {
        Self.next(weekday, after: date, in: self)
    }
}

extension Date {

    public func next(_ weekday: Locale.Weekday, in calendar: Calendar) -> Date? {
        Calendar.next(weekday, after: self, in: calendar)
    }
}
