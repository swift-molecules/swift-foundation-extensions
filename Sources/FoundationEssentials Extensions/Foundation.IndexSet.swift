import Foundation

extension IndexSet {
    /// SwiftUI's `move(fromOffsets:toOffset:)` for a platform-free domain: the
    /// elements at `offsets` land, in order, before the element at `destination`.
    public static func move<Element>(
        _ elements: [Element],
        offsets: IndexSet,
        to destination: Int
    ) -> [Element] {
        let moving = offsets.map { elements[$0] }
        let before = (0..<destination).filter { !offsets.contains($0) }.map { elements[$0] }
        let after = (destination..<elements.count).filter { !offsets.contains($0) }.map { elements[$0] }
        return before + moving + after
    }
}
