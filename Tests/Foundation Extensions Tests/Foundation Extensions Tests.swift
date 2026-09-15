import Foundation
import Testing

import Foundation_Extensions

@Suite
struct `Foundation Extensions` {

    @Test
    func `The umbrella re-exports every type module`() {
        #expect(DateComponents.zero == DateComponents())
        #expect(TimeInterval.minute == 60)
    }
}
