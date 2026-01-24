import XCTest
import Combine
import UIKit
@testable import UIExtensions

final class CombineExtensionsTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }

    func test_whenControlEventFires_thenPublisherEmits() {
        let button = UIButton()
        var fireCount = 0

        button.publisher(for: .touchUpInside)
            .sink { fireCount += 1 }
            .store(in: &cancellables)

        button.sendActions(for: .touchUpInside)
        button.sendActions(for: .touchUpInside)

        XCTAssertEqual(fireCount, 2)
    }

    func test_whenTextChanges_thenTextPublisherEmitsNewValue() {
        let textField = UITextField()
        var received: [String] = []

        textField.textPublisher
            .sink { received.append($0) }
            .store(in: &cancellables)

        textField.text = "A"
        textField.sendActions(for: .editingChanged)
        textField.text = "B"
        textField.sendActions(for: .editingChanged)

        XCTAssertEqual(received.suffix(2), ["A", "B"])
    }

    func test_whenButtonTapped_thenTapPublisherEmits() {
        let button = UIButton()
        var fired = false

        button.tapPublisher
            .sink { fired = true }
            .store(in: &cancellables)

        button.sendActions(for: .touchUpInside)

        XCTAssertTrue(fired)
    }
}
