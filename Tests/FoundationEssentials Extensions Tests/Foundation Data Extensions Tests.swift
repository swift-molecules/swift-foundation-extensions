import Foundation
import Testing

@testable import FoundationEssentials_Extensions

enum `Foundation Data Extensions Tests` {}

extension `Foundation Data Extensions Tests` {
    @Suite
    struct `Foundation Data Extensions` {

        @Test
        func `Appending a string appends its UTF-8 bytes`() {
            var data = Data("ab".utf8)
            data.append("cd")
            #expect(String(decoding: data, as: UTF8.self) == "abcd")
        }
    }
}
