//
//  RoutineCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/15.
//

import UIKit
import SnapKit
import Then

class RoutineCell : UICollectionViewCell {
    private let bodyPartView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color929292.cgColor
        $0.layer.cornerRadius = 23 / 2
    }
    
    private let bodyPartLabel = UILabel().then {
        $0.text = "어깨"
        $0.textColor = .color929292
        $0.font = .pretendard(.regular, size: 14)
    }
    
    private let weightTrainingLabel = UILabel().then {
        $0.text = "배틀 로프"
        $0.font = .pretendard(.regular, size: 16)
    }
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .colorF3F3F3
        layer.cornerRadius = 8
        
        setupLayout()
        setupConstraints()
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ACTIONS
    func setupLayout() {
        contentView.addSubview(bodyPartView)
        bodyPartView.addSubview(bodyPartLabel)
        
        contentView.addSubview(weightTrainingLabel)
    }
    
    func setupConstraints() {
        bodyPartView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(37)
            $0.height.equalTo(23)
        }
        
        bodyPartLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(bodyPartView)
        }
        
        weightTrainingLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

