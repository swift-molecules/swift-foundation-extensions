import Foundation

extension String {

    /// The string without leading and trailing whitespace and newlines.
    public static func trimmed(_ string: String) -> String {
        string.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public var trimmed: String {
        Self.trimmed(self)
    }
}
