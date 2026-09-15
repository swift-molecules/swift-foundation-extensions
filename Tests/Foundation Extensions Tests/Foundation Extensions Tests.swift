import Foundation
import Testing

import Foundation_Extensions

@Suite
struct `Foundation Extensions` {

    @Test
    func `The umbrella re-exports every type module`() {
        var array = [1, 2]
        array.move(offsets: [1], to: 0)
        #expect(array == [2, 1])
        #expect(DateComponents.zero == DateComponents())
        #expect(TimeInterval.minute == 60)
    }
}
