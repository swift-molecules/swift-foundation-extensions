import Foundation

extension Array {
    /// Convenience over `IndexSet.move(_:offsets:to:)`.
    public mutating func move(offsets: IndexSet, to destination: Int) {
        self = IndexSet.move(self, offsets: offsets, to: destination)
    }
}
