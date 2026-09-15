import Foundation
import Testing

@testable import Foundation_Extensions

@Suite
struct Test {

    @Suite
    struct `Array Move` {

        @Test
        func `Moving one element forward lands it before the destination`() {
            var array = ["a", "b", "c", "d"]
            array.move(offsets: [0], to: 3)
            #expect(array == ["b", "c", "a", "d"])
        }

        @Test
        func `Moving several elements keeps their order`() {
            var array = [1, 2, 3, 4, 5]
            array.move(offsets: [1, 3], to: 0)
            #expect(array == [2, 4, 1, 3, 5])
        }

        @Test
        func `Moving to the end appends`() {
            var array = [1, 2, 3]
            array.move(offsets: [0], to: 3)
            #expect(array == [2, 3, 1])
        }
    }

    @Suite
    struct `Safe Array` {

        @Test
        func `Safe subscript returns element for valid index`() async throws {
            let array = [1, 2, 3, 4, 5]

            #expect(array[safe: 0] == 1)
            #expect(array[safe: 2] == 3)
            #expect(array[safe: 4] == 5)
        }

        @Test
        func `Safe subscript returns nil for negative index`() async throws {
            let array = [1, 2, 3]

            #expect(array[safe: -1] == nil)
            #expect(array[safe: -10] == nil)
        }

        @Test
        func `Safe subscript returns nil for out of bounds index`() async throws {
            let array = [1, 2, 3]

            #expect(array[safe: 3] == nil)
            #expect(array[safe: 10] == nil)
        }

        @Test
        func `Safe subscript works with empty array`() async throws {
            let array: [Int] = []

            #expect(array[safe: 0] == nil)
            #expect(array[safe: -1] == nil)
            #expect(array[safe: 1] == nil)
        }

        @Test
        func `Safe subscript works with different types`() async throws {
            let stringArray = ["hello", "world", "swift"]
            let boolArray = [true, false, true]

            #expect(stringArray[safe: 1] == "world")
            #expect(stringArray[safe: 5] == nil)

            #expect(boolArray[safe: 0] == true)
            #expect(boolArray[safe: 3] == nil)
        }
    }
}
