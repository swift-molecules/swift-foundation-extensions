import Foundation
import Testing

@testable import FoundationInternationalization_Extensions

@Suite
struct `FoundationInternationalization Extensions` {

    let utc: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        return calendar
    }()

    @Test
    func `A weekday numbers as Calendar does`() {
        #expect(Locale.Weekday.sunday.number == 1)
        #expect(Locale.Weekday.saturday.number == 7)
    }

    @Test
    func `The next weekday is the first one strictly after the moment, at its start`() throws {
        // 2025-07-26 is a Saturday.
        let saturday = try #require(utc.date(from: DateComponents(year: 2025, month: 7, day: 26)))

        #expect(saturday.next(.saturday, in: utc) == utc.date(from: DateComponents(year: 2025, month: 8, day: 2)))
        #expect(saturday.next(.monday, in: utc) == utc.date(from: DateComponents(year: 2025, month: 7, day: 28)))
        #expect(Calendar.next(.monday, after: saturday, in: utc) == utc.next(.monday, after: saturday))
    }
}
