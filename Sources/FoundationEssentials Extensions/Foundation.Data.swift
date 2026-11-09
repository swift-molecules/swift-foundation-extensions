public import Foundation

extension Foundation.Data {
    /// Appends the UTF-8 bytes of `string`. UTF-8 encodes every string, so this cannot fail.
    public mutating func append(_ string: String) {
        self.append(contentsOf: string.utf8)
    }

    /// Appends `string` in `encoding`.
    ///
    /// Throws `CocoaError.fileWriteInapplicableStringEncoding`, as Foundation's own string writing does,
    /// and appends nothing, when `encoding` cannot represent `string`.
    public mutating func append(
        _ string: String,
        encoding: String.Encoding
    ) throws(CocoaError) {
        guard let data = string.data(using: encoding) else {
            throw CocoaError(.fileWriteInapplicableStringEncoding)
        }
        self.append(data)
    }
}
