import Foundation

extension Array {
    public subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Array {
    /// SwiftUI's `move(fromOffsets:toOffset:)` for a platform-free domain: the
    /// selected elements land, in order, before the element at the destination.
    public mutating func move(offsets: IndexSet, to destination: Int) {
        let moving = offsets.map { self[$0] }
        let before = (0..<destination).filter { !offsets.contains($0) }.map { self[$0] }
        let after = (destination..<count).filter { !offsets.contains($0) }.map { self[$0] }
        self = before + moving + after
    }
}
