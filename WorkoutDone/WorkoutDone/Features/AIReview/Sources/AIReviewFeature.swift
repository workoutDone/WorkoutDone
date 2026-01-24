import UIKit
import SwiftUI
import AIReviewInterface
import UIExtensions

public struct AIReviewFeature: AIReviewFeatureProviding {
    public init() {}

    public func makeViewController() -> UIViewController {
        let viewController = UIHostingController(rootView: AIReviewView())
        viewController.title = "AI Review"
        return viewController
    }
}
