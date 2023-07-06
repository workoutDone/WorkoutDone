//
//  MyRoutineCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/29.
//

import UIKit

class MyRoutineCell: UITableViewCell {

    let outerView = UIView().then {
        $0.backgroundColor = .colorF6F6F6
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
    
    var selectedIndexView = UIView().then {
        $0.backgroundColor = .color7442FF
        $0.layer.cornerRadius = 12
    }
    
    var selectedIndexLabel = UILabel().then {
        $0.text = "0"
        $0.textColor = .colorFFFFFF
        $0.font = .pretendard(.semiBold, size: 15)
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
        [routineIndexLabel, routineTitleLabel, openImage, selectedIndexView].forEach {
            outerView.addSubviews($0)
        }
        selectedIndexView.addSubview(selectedIndexLabel)
    }
    
    func setupConstraints() {
        outerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        routineIndexLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(19)
        }
        
        routineTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(19)
            $0.top.equalToSuperview().offset(30)
        }
        
        openImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-21)
            $0.width.equalTo(16)
            $0.height.equalTo(9)
        }
        
        selectedIndexView.snp.makeConstraints {
            $0.top.equalTo(outerView).offset(-8)
            $0.trailing.equalTo(outerView).offset(8)
            $0.width.height.equalTo(24)
        }
        
        selectedIndexLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(selectedIndexView)
        }
    }
}
