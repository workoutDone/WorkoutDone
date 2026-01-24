import XCTest
import UIKit
@testable import UIExtensions

final class UIExtensionsTests: XCTestCase {
    func test_whenColorCreatedWithHex_thenMatchesRGBComponents() {
        let color = UIColor(hex: 0x112233)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        let result = color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        XCTAssertTrue(result)
        XCTAssertEqual(red, 0x11 / 255.0, accuracy: 0.001)
        XCTAssertEqual(green, 0x22 / 255.0, accuracy: 0.001)
        XCTAssertEqual(blue, 0x33 / 255.0, accuracy: 0.001)
        XCTAssertEqual(alpha, 1.0, accuracy: 0.001)
    }

    func test_whenAddArrangedSubviews_thenAllViewsAdded() {
        let stackView = UIStackView()
        let first = UIView()
        let second = UIView()

        stackView.addArrangedSubviews(first, second)

        XCTAssertEqual(stackView.arrangedSubviews.count, 2)
    }

    func test_whenRoutineOrder_thenUsesSectionAlphabet() {
        let indexPath = IndexPath(row: 0, section: 1)

        let order = indexPath.routineOrder

        XCTAssertEqual(order, "B")
    }
}
