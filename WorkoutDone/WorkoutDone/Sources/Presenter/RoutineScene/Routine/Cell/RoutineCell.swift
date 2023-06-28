//
//  RoutineCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/15.
//

import UIKit
import SnapKit
import Then

protocol EditDelegate : AnyObject {
    func editButtonTapped()
}

class RoutineCell : UITableViewCell {
    var seletedIndex = -1
    
    weak var delegate: EditDelegate?
    
    let outerView = UIView().then {
        $0.backgroundColor = .colorF6F6F6
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    let innerBackgroundView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    let innerView = UIView().then {
        $0.backgroundColor = .clear
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
    
    let openImage = UIImageView().then {
        $0.image = UIImage(named: "open")
        $0.contentMode = .scaleAspectFit
    }
    
    let editButton = UIButton().then {
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .colorFFFFFF
        $0.setTitle("수정하기", for: .normal)
        $0.setTitleColor(UIColor.color363636, for: .normal)
        $0.titleLabel?.font = .pretendard(.semiBold, size: 14)
    }
    
    // MARK: - LIFECYCLE
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        setupConstraints()
        
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
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
        outerView.addSubview(innerBackgroundView)
        innerBackgroundView.addSubview(innerView)
        [routineIndexLabel, routineTitleLabel, openImage, editButton].forEach {
            innerView.addSubviews($0)
        }
    }
    
    func setupConstraints() {
        outerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        innerBackgroundView.snp.makeConstraints {
            $0.top.leading.equalTo(outerView).offset(1)
            $0.trailing.equalTo(outerView).offset(-1)
            $0.bottom.equalTo(outerView)
        }
        
        innerView.snp.makeConstraints {
            $0.top.leading.equalTo(innerBackgroundView)
            $0.trailing.equalTo(innerBackgroundView)
            $0.bottom.equalTo(innerBackgroundView)
        }
        
        routineIndexLabel.snp.makeConstraints {
            $0.top.equalTo(outerView).offset(15)
            $0.leading.equalTo(outerView).offset(19)
        }
        
        routineTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(outerView).offset(19)
            $0.top.equalTo(outerView).offset(31)
        }
        
        openImage.snp.makeConstraints {
            $0.top.equalTo(outerView).offset(29)
            $0.trailing.equalTo(outerView).offset(-20)
            $0.width.height.equalTo(16.3)
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(outerView).offset(20)
            $0.trailing.equalTo(outerView).offset(-20)
            $0.width.equalTo(65)
            $0.height.equalTo(27)
        }
    }
    
    @objc func editButtonTapped() {
        delegate?.editButtonTapped()
    }
}

