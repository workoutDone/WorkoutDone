//
//  MyRoutineDetailCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/30.
//

import UIKit

class MyRoutineDetailCell: UITableViewCell {
    let outerView = UIView().then {
        $0.backgroundColor = .colorCCCCCC
    }
    
    let innerView = UIView().then {
        $0.backgroundColor = .colorFFFFFF
    }

    private let routineView = UIView().then {
        $0.backgroundColor = .colorE6E0FF
        $0.layer.cornerRadius = 8
    }
    
    private let bodyPartView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color7442FF.cgColor
        $0.layer.cornerRadius = 23 / 2
    }
    
    let bodyPartLabel = UILabel().then {
        $0.text = "어깨"
        $0.textColor = .color7442FF
        $0.font = .pretendard(.regular, size: 14)
    }
    
    let weightTrainingLabel = UILabel().then {
        $0.text = "배틀 로프"
        $0.font = .pretendard(.regular, size: 16)
    }
    
    // MARK: - LIFECYCLE
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
    }
    
    // MARK: - ACTIONS
    func setupLayout() {
        contentView.addSubview(outerView)
        outerView.addSubview(innerView)
        innerView.addSubview(routineView)
        
        routineView.addSubview(bodyPartView)
        bodyPartView.addSubview(bodyPartLabel)
        routineView.addSubview(weightTrainingLabel)
    }
    
    func setupConstraints() {
        outerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        innerView.snp.makeConstraints {
            $0.top.bottom.equalTo(outerView)
            $0.leading.equalTo(outerView).offset(1)
            $0.trailing.equalTo(outerView).offset(-1)
        }
        
        routineView.snp.makeConstraints {
            $0.top.equalTo(outerView)
            $0.leading.equalTo(outerView).offset(20)
            $0.trailing.equalTo(outerView).offset(-20)
            $0.bottom.equalTo(outerView).offset(-8)
        }
        
        bodyPartView.snp.makeConstraints {
            $0.leading.equalTo(routineView).offset(10)
            $0.centerY.equalTo(routineView)
            $0.width.equalTo(37)
            $0.height.equalTo(23)
        }
        
        bodyPartLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(bodyPartView)
        }
        
        weightTrainingLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(routineView)
        }
    }

}
