public import Foundation

extension Foundation.Data {
    /// Appends the UTF-8 bytes of `string`. UTF-8 encodes every string, so this cannot fail.
    public mutating func append(_ string: String) {
        self.append(contentsOf: string.utf8)
    }

    /// Appends `string` in `encoding`.
    ///
    /// Throws, and appends nothing, when `encoding` cannot represent `string`.
    public mutating func append(
        _ string: String,
        encoding: String.Encoding
    ) throws(String.Encoding.Error) {
        guard let data = string.data(using: encoding) else {
            throw String.Encoding.Error(encoding: encoding)
        }
        self.append(data)
    }
}

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
