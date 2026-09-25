import Foundation
import Testing

@testable import FoundationEssentials_Extensions

@Suite
struct `Foundation AttributedString Extensions` {

    @Test
    func `Emphasizing ranges marks exactly those ranges strongly`() {
        let text = "a stichting has members"
        let marked = AttributedString(text, emphasizing: [text.range(of: "stichting")!])
        #expect(marked.runs.filter { $0.inlinePresentationIntent == .stronglyEmphasized }.map { String(marked[$0.range].characters) } == ["stichting"])
        #expect(String(marked.characters) == text)
    }

    @Test
    func `Highlighting turns the text between markers into strongly emphasized runs and drops the markers`() {
        let marked = AttributedString(highlighting: "a [x] and [y]", open: "[", close: "]")
        #expect(String(marked.characters) == "a x and y")
        #expect(marked.runs.filter { $0.inlinePresentationIntent == .stronglyEmphasized }.map { String(marked[$0.range].characters) } == ["x", "y"])
    }
}
