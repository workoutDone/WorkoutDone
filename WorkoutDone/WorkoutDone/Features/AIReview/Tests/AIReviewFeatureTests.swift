import XCTest
import UIKit
import SwiftUI
import AIReviewInterface
@testable import AIReview

final class AIReviewFeatureTests: XCTestCase {
    func test_whenFeatureProvidesViewController_thenReturnsHostingController() {
        let feature: AIReviewFeatureProviding = AIReviewFeature()

        let viewController = feature.makeViewController()

        XCTAssertTrue(viewController is UIHostingController<AIReviewView>)
    }

    func test_whenViewLoads_thenTitleIsSet() {
        let feature = AIReviewFeature()
        let viewController = feature.makeViewController()

        _ = viewController.view

        XCTAssertEqual(viewController.title, "AI Review")
    }
}
