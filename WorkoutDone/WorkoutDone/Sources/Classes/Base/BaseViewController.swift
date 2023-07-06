//
//  BaseViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/03.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController : UIViewController {
    var disposeBag = DisposeBag()

//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        hidesBottomBarWhenPushed = true
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupConstraints()
        setupBinding()
        setComponents()
        actions()
    }
    
    // MARK: - 서브뷰 추가 함수
    func setupLayout() {
        /// Override Layout
        /// addSubview
    }
    // MARK: - 레이아웃 정의 함수
    func setupConstraints() {
        /// Override Constraints
        /// snapkit
    }
    // MARK: - 컴포넌트 설정 함수
    func setComponents() {
        /// Override setComponent
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        let backBarButtonItem = UIBarButtonItem(title: "뒤로가기", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .color000000
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    // MARK: - RX 관련 코드
    func setupBinding() {
        /// Override Binding
        /// RX
    }
    // MARK: - Action 함수
    func actions() {
        /// Override Actions
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(popAction(_:)))
        swipeLeftGesture.direction = .right
        view.addGestureRecognizer(swipeLeftGesture)
    }
    @objc func popAction(_ sender : UISwipeGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
}

