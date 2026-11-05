import Foundation
import Testing

@testable import FoundationEssentials_Extensions

@Suite
struct `Foundation TimeInterval Extensions` {

    @Test
    func `Units multiply and divide`() {
        #expect(TimeInterval(2).hours == 7200)
        #expect(TimeInterval.week.asDays == 7)
    }

    @Test
    func `formattedDuration picks the largest fitting unit`() {
        #expect(TimeInterval(30).formattedDuration == "30s")
        #expect(TimeInterval(90).formattedDuration == "2m")
        #expect(TimeInterval.day.formattedDuration == "1.0d")
        #expect(TimeInterval(2.5).formattedDuration == "2s")
        #expect(TimeInterval(-30).formattedDuration == "-30s")
        #expect((TimeInterval.hour * 1.25).formattedDuration == "1.2h")
    }

    @Test
    func `formattedDuration picks the unit by magnitude and keeps the sign`() {
        #expect(TimeInterval(-90).formattedDuration == "-2m")
        #expect(TimeInterval(-7200).formattedDuration == "-2.0h")
        #expect((-TimeInterval.day * 1.5).formattedDuration == "-1.5d")
        #expect((-TimeInterval.week * 2).formattedDuration == "-2.0w")
    }
}
