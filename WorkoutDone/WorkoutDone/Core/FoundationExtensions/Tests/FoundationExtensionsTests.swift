import XCTest
@testable import FoundationExtensions

final class FoundationExtensionsTests: XCTestCase {
    func test_whenStringIsYYMMdd_thenConvertsToDate() {
        let dateString = "24.12.31"

        let date = dateString.yyMMddToDate()

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .day], from: date ?? Date(timeIntervalSince1970: 0))
        XCTAssertEqual(components.year, 2024)
        XCTAssertEqual(components.month, 12)
        XCTAssertEqual(components.day, 31)
    }

    func test_whenTransformDate_thenRemovesLeadingTwoChars() {
        let source = "2024.12.31"

        let transformed = source.transformDate()

        XCTAssertEqual(transformed, "24.12.31")
    }

    func test_whenTruncateDecimalPoint_thenFormatsToSingleDecimal() {
        let value = 70.123

        let formatted = value.truncateDecimalPoint()

        XCTAssertEqual(formatted, "70.1")
    }

    func test_whenNotificationNameSelectedDate_thenRawValueMatches() {
        XCTAssertEqual(Notification.Name.selectedDateInt.rawValue, "selectedDate")
    }
}
