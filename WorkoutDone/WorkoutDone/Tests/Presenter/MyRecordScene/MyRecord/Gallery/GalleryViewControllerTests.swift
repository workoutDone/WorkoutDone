import XCTest
import UIKit
@testable import WorkoutDone

final class GalleryViewControllerTests: XCTestCase {
    func test_whenMonthImagesEmpty_thenCollectionViewReloadDoesNotCrash() {
        let viewController = GalleryViewController()
        viewController.loadViewIfNeeded()
        viewController.view.frame = CGRect(x: 0, y: 0, width: 390, height: 636)

        guard let collectionView = viewController.view.subviews.compactMap({ $0 as? UICollectionView }).first else {
            XCTFail("Expected collection view to be present in view hierarchy.")
            return
        }
        collectionView.frame = viewController.view.bounds

        viewController.sortFrame = false
        viewController.monthImages = [:]
        viewController.month = []

        collectionView.reloadData()
        collectionView.layoutIfNeeded()

        XCTAssertEqual(collectionView.numberOfSections, 2)
    }
}
