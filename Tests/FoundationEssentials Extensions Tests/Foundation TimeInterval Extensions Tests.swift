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
}
