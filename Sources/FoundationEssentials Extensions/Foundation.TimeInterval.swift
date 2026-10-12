public import Foundation

extension Foundation.TimeInterval {

    public static var minute: Foundation.TimeInterval { 60 }

    public static var hour: Foundation.TimeInterval { 3600 }

    public static var day: Foundation.TimeInterval { 86400 }

    public static var week: Foundation.TimeInterval { 604800 }

    public var minutes: Foundation.TimeInterval { self * .minute }

    public var hours: Foundation.TimeInterval { self * .hour }

    public var days: Foundation.TimeInterval { self * .day }

    public var weeks: Foundation.TimeInterval { self * .week }

    public var asMinutes: Double { self / .minute }

    public var asHours: Double { self / .hour }

    public var asDays: Double { self / .day }

    public var asWeeks: Double { self / .week }

    public var formattedDuration: String {
        if self < .minute {
            return "\(Self.fixed(self, fractionDigits: 0))s"
        } else if self < .hour {
            return "\(Self.fixed(self.asMinutes, fractionDigits: 0))m"
        } else if self < .day {
            return "\(Self.fixed(self.asHours, fractionDigits: 1))h"
        } else if self < .week {
            return "\(Self.fixed(self.asDays, fractionDigits: 1))d"
        } else {
            return "\(Self.fixed(self.asWeeks, fractionDigits: 1))w"
        }
    }

    private static func fixed(_ value: Double, fractionDigits: Int) -> String {
        let scale = fractionDigits == 0 ? 1.0 : 10.0
        let scaled = (value * scale).rounded(.toNearestOrEven)
        guard scaled.isFinite, scaled.magnitude < 1e15 else { return "\(value)" }
        guard fractionDigits > 0 else { return "\(Int(scaled))" }
        let tenths = Int(scaled.magnitude)
        return "\(scaled < 0 ? "-" : "")\(tenths / 10).\(tenths % 10)"
    }
}
