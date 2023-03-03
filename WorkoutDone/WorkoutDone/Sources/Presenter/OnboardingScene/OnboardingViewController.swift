//
//  OnboardingViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/03.
//

import UIKit
import SnapKit
import Then

struct Onboarding {
    var image: String
    var text: String
}

class OnboardingViewController : UIViewController {
    // MARK: - PROPERTIES
    let numberOfPages = 3
    let onboardingInfo = [
        Onboarding(image: "onboarding1", text: "onboarding1"),
        Onboarding(image: "onboarding2", text: "onboarding2"),
        Onboarding(image: "onboarding3", text: "onboarding3")
    ]
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    private let pageControl = UIPageControl().then {
        $0.numberOfPages = 3
        $0.currentPage = 0
        $0.pageIndicatorTintColor = .colorD6C8FF
        $0.currentPageIndicatorTintColor = .color7442FF
        $0.transform = CGAffineTransform(scaleX: 1, y: 1)
    }
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setLayout()
        
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    // MARK: - ACTIONS
    func setLayout() {
        collectionView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(554)
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(collectionView.snp.bottom).offset(58)
        }
    }
}

extension OnboardingViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as? OnboardingCell else { return UICollectionViewCell() }
        cell.onboardingImage.image = UIImage(named: onboardingInfo[indexPath.row].image)
        cell.onboardingText.text = onboardingInfo[indexPath.row].text
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.size.width
        let x = scrollView.contentOffset.x + (width / 2)
        let nextPage = Int(x/width)
        pageControl.currentPage = nextPage
    }
}


