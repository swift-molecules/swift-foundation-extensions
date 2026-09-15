import Foundation
import Testing

@testable import FoundationEssentials_Extensions

@Suite
struct `Foundation Data Extensions` {

    @Test
    func `Appending a string appends its UTF-8 bytes`() {
        var data = Data("ab".utf8)
        data.append("cd")
        #expect(String(decoding: data, as: UTF8.self) == "abcd")
    }
}
