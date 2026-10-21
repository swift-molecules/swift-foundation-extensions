import Foundation
import Foundation_Extensions
import Testing

@Suite
struct `Foundation Extensions` {

    @Test
    func `The umbrella re-exports every type module`() {
        #expect(DateComponents.zero == DateComponents())
        #expect(TimeInterval.minute == 60)
    }
}
