//
//  RoutineCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/15.
//

import UIKit
import SnapKit
import Then

class RoutineCell : UITableViewCell {
    var seletedIndex = -1
    
    private let routineIndexLabel = UILabel().then {
        $0.text = "routine A"
        $0.textColor = .color7442FF
        $0.font = .pretendard(.regular, size: 12)
    }
    
    let routineTitleLabel = UILabel().then {
        $0.text = "오늘은 등 운동!"
        $0.textColor = .color121212
        $0.font = .pretendard(.semiBold, size: 16)
    }
    
    let editButton = UIButton().then {
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .colorF3F3F3
        $0.setTitle("수정하기", for: .normal)
        $0.setTitleColor(UIColor.color363636, for: .normal)
        $0.titleLabel?.font = .pretendard(.semiBold, size: 14)
        $0.isHidden = true
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
        self.addSubview(routineIndexLabel)
        self.addSubview(routineTitleLabel)
        self.addSubview(editButton)
    }
    
    func setupConstraints() {
        routineIndexLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(11)
            $0.leading.equalToSuperview().offset(39)
        }
        
        routineTitleLabel.snp.makeConstraints {
            $0.top.equalTo(routineIndexLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(39)
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(65)
            $0.height.equalTo(27)
        }
    }
}

