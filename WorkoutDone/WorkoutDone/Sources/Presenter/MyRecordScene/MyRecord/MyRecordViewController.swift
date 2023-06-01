//
//  MyRecordViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/05.
//

import UIKit
import SnapKit
import Then

class MyRecordViewController : BaseViewController {
    //MARK: - PROPERTIES
    private let pagerView = UIView()
    
    private let galleryPageAreaView = UIView()
    
    private let galleryPageButton = UIButton().then {
        $0.setTitle("갤러리", for: .normal)
        $0.titleLabel?.font = .pretendard(.semiBold, size: 18)
    }
    
    private let analyzePageAreaView = UIView()
    
    private let analyzePageButton = UIButton().then {
        $0.setTitle("분석", for: .normal)
        $0.titleLabel?.font = .pretendard(.semiBold, size: 18)
    }
    private let pagerBarBackView = UIView().then {
        $0.backgroundColor = .colorE2E2E2
    }
    
    private let pagerBarView = UIView().then {
        $0.backgroundColor = .color7442FF
        $0.layer.cornerRadius = 2
    }
    private lazy var galleryViewController = GalleryViewController()
    private lazy var analyzeViewController = AnalyzeViewController()
    
    private lazy var viewControllers : [UIViewController] = {
        return [galleryViewController, analyzeViewController]
    }()
    
    private lazy var myRecordPageViewController : UIPageViewController = {
        let viewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func setComponents() {
        super.setComponents()
        view.backgroundColor = .colorFFFFFF
        navigationItem.title = "나의 기록"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.color121212]
        
        ///PageViewController 세팅
        myRecordPageViewController.didMove(toParent: self)
        myRecordPageViewController.view.frame = self.view.frame
        myRecordPageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: true)
        
        ///갤러리 포커스 세팅
        galleryPageButton.titleLabel?.font = .pretendard(.semiBold, size: 18)
        galleryPageButton.setTitleColor(.color121212, for: .normal)
        analyzePageButton.setTitleColor(.color929292, for: .normal)
        analyzePageButton.titleLabel?.font = .pretendard(.regular, size: 18)
        
    }
    override func setupLayout() {
        super.setupLayout()
        self.addChild(myRecordPageViewController)
        [pagerView, pagerBarBackView, galleryPageAreaView, galleryPageButton, analyzePageAreaView, analyzePageButton, pagerBarView, myRecordPageViewController.view].forEach {
            view.addSubview($0)
        }
    }
    override func setupConstraints() {
        super.setupConstraints()
        pagerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(33)
        }
        galleryPageAreaView.snp.makeConstraints {
            $0.top.equalTo(pagerView.snp.top)
            $0.leading.equalTo(pagerView.snp.leading)
            $0.bottom.equalTo(pagerView.snp.bottom)
            $0.width.equalTo(UIScreen.main.bounds.size.width / 2)
        }
        galleryPageButton.snp.makeConstraints {
            $0.top.equalTo(galleryPageAreaView.snp.top)
            $0.centerX.equalTo(galleryPageAreaView)
            $0.bottom.equalTo(galleryPageAreaView.snp.bottom)
            $0.width.equalTo(108)
        }
        analyzePageAreaView.snp.makeConstraints {
            $0.top.equalTo(pagerView.snp.top)
            $0.leading.equalTo(galleryPageAreaView.snp.trailing)
            $0.trailing.equalTo(pagerView.snp.trailing)
            $0.bottom.equalTo(pagerView.snp.bottom)
        }
        analyzePageButton.snp.makeConstraints {
            $0.top.equalTo(analyzePageAreaView.snp.top)
            $0.centerX.equalTo(analyzePageAreaView)
            $0.bottom.equalTo(analyzePageAreaView.snp.bottom)
            $0.width.equalTo(108)
        }
        
        pagerBarBackView.snp.makeConstraints {
            $0.top.equalTo(pagerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        pagerBarView.snp.makeConstraints {
            $0.centerX.equalTo(galleryPageButton)
            $0.height.equalTo(2)
            $0.centerY.equalTo(pagerBarBackView)
            $0.width.equalTo(108)
        }
        myRecordPageViewController.view.snp.remakeConstraints {
            $0.top.equalTo(pagerBarBackView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    //MARK: - Actions
    override func actions() {
//        super.actions()
        galleryPageButton.addTarget(self, action: #selector(galleryButtonTapped), for: .touchUpInside)
        analyzePageButton.addTarget(self, action: #selector(analyzeButtonTapped), for: .touchUpInside)
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeActions(_:)))
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeActions(_:)))
        swipeLeftGesture.direction = .left
        swipeRightGesture.direction = .right
        view.addGestureRecognizer(swipeLeftGesture)
        view.addGestureRecognizer(swipeRightGesture)
    }
    @objc func galleryButtonTapped() {
        swipeToggleAnimation(left: true)
        myRecordPageViewController.setViewControllers([viewControllers[0]], direction: .reverse, animated: true)
    }
    @objc func analyzeButtonTapped() {
        swipeToggleAnimation(left: false)
        myRecordPageViewController.setViewControllers([viewControllers[1]], direction: .forward, animated: true)
    }
    @objc func swipeActions(_ sender : UISwipeGestureRecognizer) {
        if sender.direction == .right {
            swipeToggleAnimation(left: true)
            myRecordPageViewController.setViewControllers([viewControllers[0]], direction: .reverse, animated: true)
        }
        else if sender.direction == .left {
            swipeToggleAnimation(left: false)
            myRecordPageViewController.setViewControllers([viewControllers[1]], direction: .forward, animated: true)
        }
    }
    func swipeToggleAnimation(left : Bool) {
        if left {
            galleryPageButton.titleLabel?.font = .pretendard(.semiBold, size: 18)
            galleryPageButton.setTitleColor(.color121212, for: .normal)
            analyzePageButton.setTitleColor(.color929292, for: .normal)
            analyzePageButton.titleLabel?.font = .pretendard(.regular, size: 18)
            pagerBarView.snp.remakeConstraints {
                $0.centerX.equalTo(galleryPageButton.snp.centerX)
                $0.height.equalTo(2)
                $0.centerY.equalTo(pagerBarBackView)
                $0.width.equalTo(108)
            }
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.pagerBarView.superview?.layoutIfNeeded()
            })
        } else {
            analyzePageButton.titleLabel?.font = .pretendard(.semiBold, size: 18)
            galleryPageButton.titleLabel?.font = .pretendard(.regular, size: 18)
            analyzePageButton.setTitleColor(.color121212, for: .normal)
            galleryPageButton.setTitleColor(.color929292, for: .normal)
            
            self.pagerBarView.snp.remakeConstraints {
                $0.centerX.equalTo(self.analyzePageButton.snp.centerX)
                $0.height.equalTo(2)
                $0.centerY.equalTo(self.pagerBarBackView)
                $0.width.equalTo(108)
            }
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.pagerBarView.superview?.layoutIfNeeded()
            })
        }
    }
}
