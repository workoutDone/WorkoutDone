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
    
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupConstraints()
        setupBinding()
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
    // MARK: - RX 관련 코드
    func setupBinding() {
        /// Override Binding
        /// RX
    }
    // MARK: - Action 함수
    func actions() {
        /// Override Actions
    }
    
}

