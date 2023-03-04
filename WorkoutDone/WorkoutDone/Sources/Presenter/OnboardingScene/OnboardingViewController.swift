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

class OnboardingViewController : BaseViewController {
    // MARK: - PROPERTIES
    let numberOfPages = 3
    var currentPage = 0
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
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private lazy var pageControl = UIPageControl().then {
        $0.numberOfPages = numberOfPages
        $0.currentPage = currentPage

        $0.setCurrentPageIndicatorImage(UIImage(named: "currentPage"), forPage: currentPage)
        $0.preferredIndicatorImage = UIImage(named: "page")
        
        $0.pageIndicatorTintColor = .colorD6C8FF
        $0.currentPageIndicatorTintColor = .color7442FF
    }
    
    private let nextButton = GradientButton(colors: [UIColor.color8E36FF.cgColor, UIColor.color7442FF.cgColor]).then {
        $0.setTitle("다음으로", for: .normal)
        $0.titleLabel?.font = .pretendard(.bold, size: 18)
    }
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [collectionView, pageControl, nextButton].forEach {
            view.addSubview($0)
        }
        
        setLayout()
        setDelegateDataSource()
        setAction()
    }
    
    // MARK: - ACTIONS
    func setLayout() {
        collectionView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view.frame.width * 554 / 390)
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(collectionView.snp.bottom).offset(58)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(pageControl.snp.bottom).offset(52)
            //$0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-29)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(65)
        }
    }
    
    func setDelegateDataSource() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setAction() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc func nextButtonTapped(sender: UIButton!) {
        if currentPage < numberOfPages - 1 {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } else if currentPage == numberOfPages - 1 {
            let homeVC = HomeViewController()
            homeVC.modalPresentationStyle = .fullScreen
            self.present(homeVC, animated: false)
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
        currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        self.pageControl.currentPage = currentPage
        pageControl.setCurrentPageIndicatorImage(UIImage(named: "currentPage"), forPage: currentPage)
    }
}

