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
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setLayout()
        
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
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
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(pageControl.snp.bottom).offset(52)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(65)
        }
    }
    
    @objc func nextButtonTapped(sender: UIButton!) {
        if currentPage < numberOfPages - 1 {
            
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
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


class GradientButton: UIButton {
    let gradient = CAGradientLayer()
    
    init(colors: [CGColor]) {
        super.init(frame: .zero)
        
        gradient.frame = bounds
        gradient.colors = colors
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        gradient.cornerRadius = 12
        
        layer.addSublayer(gradient)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
}
