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
    var image : String
    var text : String
}

class OnboardingViewController : BaseViewController {
    // MARK: - PROPERTIES
    let numberOfPages : Int = 3
    var currentPage : Int = 0
    let onboardingInfo = [
        Onboarding(image: "onboarding1", text: "프레임을 이용해서 쉽게 오운완 사진을 찍어보세요!"),
        Onboarding(image: "onboarding2", text: "운동 내용을 기록해보세요!"),
        Onboarding(image: "onboarding3", text: "오운완 사진과 그래프를 통해 \n나의 변화된 모습을 실감할 수 있어요!")
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
    
        setDelegateDataSource()
    }
    
    // MARK: - ACTIONS
    override func setupLayout() {
        super.setupLayout()
        view.backgroundColor = .colorFFFFFF
        [collectionView, pageControl, nextButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func actions() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        collectionView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide).offset(0)
            $0.top.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(68)
            $0.leading.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(488)
        }

        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.greaterThanOrEqualTo(collectionView.snp.bottom).offset(21)
            $0.top.lessThanOrEqualTo(collectionView.snp.bottom).offset(88)
        }

        nextButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(pageControl.snp.bottom).offset(40)
            $0.top.lessThanOrEqualTo(pageControl.snp.bottom).offset(52)
            $0.bottom.greaterThanOrEqualTo(view.safeAreaLayoutGuide).offset(-29)
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(-20)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(65)
        }
    }
    
    func setDelegateDataSource() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc func nextButtonTapped(sender: UIButton!) {
        if currentPage < numberOfPages - 1 {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } else if currentPage == numberOfPages - 1 {
            let tabBarC = TabBarController()
            tabBarC.modalPresentationStyle = .fullScreen
            self.present(tabBarC, animated: false)
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
        if currentPage == numberOfPages - 1 {
            nextButton.setTitle("시작하기", for: .normal)
        } else {
            nextButton.setTitle("다음으로", for: .normal)
        }
    }
}

