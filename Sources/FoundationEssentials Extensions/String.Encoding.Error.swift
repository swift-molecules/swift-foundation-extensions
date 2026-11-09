public import Foundation

extension String.Encoding {
    /// A string that this encoding cannot represent.
    public struct Error: Swift.Error, Hashable, Sendable {
        /// The encoding that could not represent the string.
        public let encoding: String.Encoding

        public init(encoding: String.Encoding) {
            self.encoding = encoding
        }
    }
}
