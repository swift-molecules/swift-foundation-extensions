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

        @Test
        func `Appending a string in an encoding appends its encoded bytes`() throws {
            var data = Data("ab".utf8)
            try data.append("é", encoding: .isoLatin1)
            #expect(data == Data([0x61, 0x62, 0xE9]))
        }

        @Test
        func `Appending a string its encoding cannot represent throws and appends nothing`() {
            var data = Data("ab".utf8)
            #expect(throws: String.Encoding.Error(encoding: .ascii)) {
                try data.append("é", encoding: .ascii)
            }
            #expect(data == Data("ab".utf8))
        }
    }
}
