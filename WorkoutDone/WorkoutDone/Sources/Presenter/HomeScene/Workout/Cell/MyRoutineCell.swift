//
//  MyRoutineCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/29.
//

import UIKit

class MyRoutineCell: UITableViewCell {

    let outerView = UIView().then {
        $0.backgroundColor = .colorCCCCCC
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    let innerView = UIView().then {
        $0.backgroundColor = .colorFFFFFF
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    let routineIndexLabel = UILabel().then {
        $0.text = "routine A"
        $0.textColor = .color7442FF
        $0.font = .pretendard(.regular, size: 12)
    }
    
    let routineTitleLabel = UILabel().then {
        $0.text = "오늘은 등 운동!"
        $0.textColor = .color121212
        $0.font = .pretendard(.semiBold, size: 16)
    }
    
    let openButton = UIButton().then {
        $0.setImage(UIImage(named: "open"), for: .normal)
    }
    
    // MARK: - LIFECYCLE
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
         setupLayout()
         setupConstraints()
        
        innerView.backgroundColor = .white
        innerView.layer.cornerRadius = 10
        
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
        outerView.addSubviews(innerView)
        [routineIndexLabel, routineTitleLabel, openButton].forEach {
            innerView.addSubviews($0)
        }
    }
    
    func setupConstraints() {
        outerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        innerView.snp.makeConstraints {
            $0.top.leading.equalTo(outerView).offset(1)
            $0.trailing.equalTo(outerView).offset(-1)
            $0.bottom.equalTo(outerView)
        }
        
        routineIndexLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(19)
        }
        
        routineTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(19)
            $0.top.equalToSuperview().offset(30)
        }
        
        openButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-21)
            $0.width.height.equalTo(16)
        }
    }
    
    func opendRoutine() {
//        innerView.snp.remakeConstraints {
//            $0.top.leading.equalTo(outerView).offset(1)
//            $0.trailing.equalTo(outerView).offset(-1)
//            $0.bottom.equalTo(outerView)
//        }
    }

}
