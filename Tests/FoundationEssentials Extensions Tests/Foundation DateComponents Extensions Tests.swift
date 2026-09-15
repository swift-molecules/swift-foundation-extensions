import Foundation
import Testing


@testable import FoundationEssentials_Extensions

@Suite
struct `Foundation DateComponents Extensions` {

    @Test
    func `negated reverses every component`() {
        let forward = DateComponents(day: 3, hour: 4)
        let backward = forward.negated()

        #expect(backward.day == -3)
        #expect(backward.hour == -4)
    }

    @Test
    func `adding combines two component sets`() {
        let combined = 1.day.adding(2.hours, in: gregorian)

        #expect(combined.day == 1)
        #expect(combined.hour == 2)
    }

    @Test
    func `subtracting removes a component set`() throws {
        let difference = 2.weeksOfYear.subtracting(3.days, in: gregorian)

        #expect(difference.weekOfYear == 1)
        #expect(difference.day == 4)

        let start = try #require(Date(year: 2025, month: 7, day: 1, in: gregorian))
        let moved = try #require(start.adding(difference, in: gregorian))
        #expect(start.daysBetween(moved, in: gregorian) == 11)
    }

    @Test
    func `multiplied scales every component`() {
        let scaled = 1.day.multiplied(by: 3, in: gregorian)

        #expect(scaled.day == 3)
    }

    @Test
    func `zero represents no offset`() {
        #expect(DateComponents.zero == DateComponents())
    }

    @Test
    func `Range validation rejects impossible values`() {
        #expect(DateComponents(year: 2025, month: 7, day: 26).isValid)
        #expect(!DateComponents(month: 13).isValid)
        #expect(!DateComponents(day: 32).isValid)
        #expect(!DateComponents(hour: 24).isValid)
        #expect(!DateComponents(minute: 60).isValid)
        #expect(!DateComponents(second: 60).isValid)
        #expect(!DateComponents(quarter: 5).isValid)
        #expect(!DateComponents(weekday: 8).isValid)
    }

    @Test
    func `Calendar validation rejects a leap day in a common year`() {
        #expect(DateComponents(year: 2024, month: 2, day: 29).isValid(for: gregorian))
        #expect(!DateComponents(year: 2025, month: 2, day: 29).isValid(for: gregorian))
    }

    @Test
    func `Offset-style components validate by range only`() {

        #expect(2.months.isValid(for: gregorian))
    }
}
