import Foundation
import Testing

@testable import FoundationEssentials_Extensions

@Suite
struct `Swift String Extensions` {

    @Test
    func `trimmed drops surrounding whitespace and newlines`() {
        #expect("  call \n".trimmed == "call")
        #expect(String.trimmed("\t\n ") == "")
        #expect("a b".trimmed == "a b")
    }
}
