import UIKit
import AIReview
import AIReviewInterface

struct AIReviewDemoRootBuilder {
    private let feature: AIReviewFeatureProviding

    init(feature: AIReviewFeatureProviding = AIReviewFeature()) {
        self.feature = feature
    }

    func makeRootViewController() -> UIViewController {
        feature.makeViewController()
    }
}
