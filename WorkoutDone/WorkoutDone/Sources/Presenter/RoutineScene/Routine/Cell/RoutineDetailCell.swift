//
//  RoutineDetailCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/19.
//

import UIKit
import SnapKit
import Then

class RoutineDetailCell : UITableViewCell {
    private let routineView = UIView().then {
        $0.backgroundColor = .colorF3F3F3
        $0.layer.cornerRadius = 8
    }
    
    private let bodyPartView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color929292.cgColor
        $0.layer.cornerRadius = 23 / 2
    }
    
    let bodyPartLabel = UILabel().then {
        $0.text = "어깨"
        $0.textColor = .color929292
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
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 8, right: 20))
            
    }
    
    // MARK: - ACTIONS
    func setupLayout() {
        contentView.addSubview(routineView)
        routineView.addSubview(bodyPartView)
        bodyPartView.addSubview(bodyPartLabel)
        
        routineView.addSubview(weightTrainingLabel)
    }
    
    func setupConstraints() {
        routineView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
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

