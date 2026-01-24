import XCTest
import UIKit
import AIReviewInterface
import UIExtensions
@testable import AIReviewDemo

final class AIReviewDemoRootBuilderTests: XCTestCase {
    func test_whenBuildingRoot_thenUsesProvidedFeature() {
        let expectedViewController = UIViewController()
        let feature = StubFeature(viewController: expectedViewController)
        let builder = AIReviewDemoRootBuilder(feature: feature)

        let result = builder.makeRootViewController()

        XCTAssertTrue(result === expectedViewController)
        XCTAssertEqual(feature.makeViewControllerCallCount, 1)
    }
}

private final class StubFeature: AIReviewFeatureProviding {
    private let viewController: UIViewController
    private(set) var makeViewControllerCallCount = 0

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func makeViewController() -> UIViewController {
        makeViewControllerCallCount += 1
        return viewController
    }
}
