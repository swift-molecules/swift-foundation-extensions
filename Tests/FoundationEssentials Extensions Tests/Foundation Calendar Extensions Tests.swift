import Foundation
import Testing

@testable import FoundationEssentials_Extensions

@Suite
struct `Foundation Calendar Extensions` {

    let utc = Calendar(identifier: .gregorian, timeZone: TimeZone(identifier: "UTC")!)

    @Test
    func `A calendar made with a time zone keeps it`() {
        let tokyo = Calendar(identifier: .gregorian, timeZone: TimeZone(identifier: "Asia/Tokyo")!)

        #expect(tokyo.identifier == .gregorian)
        #expect(tokyo.timeZone.identifier == "Asia/Tokyo")
    }

    @Test
    func `The day containing a moment is half-open at the next midnight`() throws {
        let noon = try #require(Date(year: 2025, month: 7, day: 26, hour: 12, in: utc))
        let day = try #require(utc.day(containing: noon))

        #expect(day.lowerBound == Date(year: 2025, month: 7, day: 26, in: utc))
        #expect(day.upperBound == Date(year: 2025, month: 7, day: 27, in: utc))
        #expect(day.contains(noon))
        #expect(!day.contains(day.upperBound))
    }

    @Test
    func `The next hour is the following whole hour, also on the hour`() throws {
        let twenty = try #require(Date(year: 2025, month: 7, day: 26, hour: 9, minute: 20, in: utc))
        let sharp = try #require(Date(year: 2025, month: 7, day: 26, hour: 9, in: utc))
        let ten = Date(year: 2025, month: 7, day: 26, hour: 10, in: utc)

        #expect(utc.nextHour(after: twenty) == ten)
        #expect(utc.nextHour(after: sharp) == ten)
        #expect(Calendar.nextHour(after: twenty, in: utc) == ten)
    }

    @Test
    func `A day and a time combine into the moment on that day, seconds dropped`() throws {
        let day = try #require(Date(year: 2025, month: 7, day: 26, hour: 15, in: utc))
        let time = try #require(Date(year: 2025, month: 1, day: 1, hour: 9, minute: 20, second: 45, in: utc))

        #expect(utc.date(day: day, time: time) == Date(year: 2025, month: 7, day: 26, hour: 9, minute: 20, in: utc))
        #expect(Calendar.date(day: day, time: time, in: utc) == utc.date(day: day, time: time))
    }
}
