import Foundation
import Testing

@testable import FoundationEssentials_Extensions

enum `Foundation FormatStyle Extensions Tests` {}

extension `Foundation FormatStyle Extensions Tests` {
    @Suite
    struct `Foundation FormatStyle Extensions` {

        @Test
        func `dateFormat formats with the given pattern`() {
            let date = Date(timeIntervalSince1970: 0)
            let style = StringDateFormat(dateFormat: "yyyy")
            #expect(style.format(date).count == 4)
        }
    }
}
