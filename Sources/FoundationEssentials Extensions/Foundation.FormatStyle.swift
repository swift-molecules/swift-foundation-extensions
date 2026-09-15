import Foundation

extension FormatStyle where Self == StringDateFormat {

    public static func dateFormat(_ dateFormat: String) -> Self {
        StringDateFormat(dateFormat: dateFormat)
    }
}

public struct StringDateFormat: FormatStyle {

    let dateFormat: String

    public func format(_ value: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: value)
    }
}
