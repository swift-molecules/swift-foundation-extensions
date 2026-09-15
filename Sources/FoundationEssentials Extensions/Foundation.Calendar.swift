import Foundation

extension Calendar {

    /// The calendar day a moment falls in, as half-open bounds: from midnight up to but not
    /// including the next midnight. A `Range` rather than Foundation's `DateInterval` because
    /// `DateInterval.contains` treats its end as inside, and the next period's first instant
    /// is not inside this one.
    public func day(containing date: Date) -> Range<Date>? {
        period(.day, containing: date)
    }

    public func week(containing date: Date) -> Range<Date>? {
        period(.weekOfYear, containing: date)
    }

    public func month(containing date: Date) -> Range<Date>? {
        period(.month, containing: date)
    }

    public func year(containing date: Date) -> Range<Date>? {
        period(.year, containing: date)
    }

    private func period(_ component: Calendar.Component, containing date: Date) -> Range<Date>? {
        guard let interval = dateInterval(of: component, for: date) else { return nil }
        return interval.start..<interval.end
    }
}

extension Calendar {

    public init(identifier: Identifier, timeZone: TimeZone) {
        self.init(identifier: identifier)
        self.timeZone = timeZone
    }
}

extension Calendar {

    /// The first instant of the hour that follows the moment: 09:20 gives 10:00, and so does 09:00.
    public static func nextHour(after date: Date, in calendar: Calendar) -> Date? {
        calendar.nextDate(after: date, matching: DateComponents(minute: 0), matchingPolicy: .nextTime)
    }

    public func nextHour(after date: Date) -> Date? {
        Self.nextHour(after: date, in: self)
    }
}

extension Calendar {

    /// The moment on `day` at the hour and minute `time` has; seconds are dropped.
    public static func date(day: Date, time: Date, in calendar: Calendar) -> Date? {
        let clock = calendar.dateComponents([.hour, .minute], from: time)
        return calendar.date(bySettingHour: clock.hour ?? 0, minute: clock.minute ?? 0, second: 0, of: day)
    }

    public func date(day: Date, time: Date) -> Date? {
        Self.date(day: day, time: time, in: self)
    }
}
