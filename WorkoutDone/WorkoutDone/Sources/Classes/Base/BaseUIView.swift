//
//  BaseUIView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/03.
//

import UIKit

class BaseUIView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        setupConstraints()
        setUI()
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
    func setUI() {
        
    }
}

