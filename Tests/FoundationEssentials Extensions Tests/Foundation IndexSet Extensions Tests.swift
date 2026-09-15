import Foundation
import Testing

@testable import FoundationEssentials_Extensions

@Suite
struct `Foundation IndexSet Extensions` {

    @Test
    func `Moving one element forward lands it before the destination`() {
        #expect(IndexSet.move(["a", "b", "c", "d"], offsets: [0], to: 3) == ["b", "c", "a", "d"])
    }

    @Test
    func `Moving several elements keeps their order`() {
        #expect(IndexSet.move([1, 2, 3, 4, 5], offsets: [1, 3], to: 0) == [2, 4, 1, 3, 5])
    }

    @Test
    func `Moving to the end appends`() {
        #expect(IndexSet.move([1, 2, 3], offsets: [0], to: 3) == [2, 3, 1])
    }

    @Test
    func `The Array convenience mutates in place`() {
        var array = [1, 2, 3]
        array.move(offsets: [2], to: 0)
        #expect(array == [3, 1, 2])
    }
}
