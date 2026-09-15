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
