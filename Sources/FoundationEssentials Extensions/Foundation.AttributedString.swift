import Foundation

extension Foundation.AttributedString {
    public init(_ text: String, emphasizing ranges: [Range<String.Index>]) {
        self = ranges.reduce(into: AttributedString(text)) { marked, range in
            if let range = Range(range, in: marked) { marked[range].inlinePresentationIntent = .stronglyEmphasized }
        }
    }

    public init(highlighting text: String, open: String, close: String) {
        self = text.components(separatedBy: open).enumerated().reduce(into: AttributedString()) { marked, part in
            let pieces = part.element.components(separatedBy: close)
            var match = AttributedString(part.offset == 0 ? "" : pieces[0])
            match.inlinePresentationIntent = .stronglyEmphasized
            marked += match + AttributedString(part.offset == 0 ? pieces[0] : pieces.dropFirst().joined())
        }
    }
}
