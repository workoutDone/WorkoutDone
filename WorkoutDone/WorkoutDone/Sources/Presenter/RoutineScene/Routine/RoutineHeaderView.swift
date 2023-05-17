//
//  RoutineHeaderView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/15.
//

import UIKit

protocol RoutineDelegate: AnyObject {
    func didSelectRoutine(index: Int)
}

class RoutineHeaderView: UICollectionReusableView {
    var seletedIndex = -1
    var delegate : RoutineDelegate?
    
    let backgroundView = UIView()
    
    let backgroundButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.colorCCCCCC.cgColor
    }

    private let routineIndexLabel = UILabel().then {
        $0.text = "routine A"
        $0.textColor = .color7442FF
        $0.font = .pretendard(.regular, size: 12)
    }
    
    private let routineTitleLabel = UILabel().then {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
        setupLayout()
        setupConstraints()
        
        backgroundButton.addTarget(self, action: #selector(backgroundButtonTapped), for: .touchUpInside)
        
    
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        self.addSubview(backgroundButton)
        backgroundButton.addSubview(routineIndexLabel)
        backgroundButton.addSubview(routineTitleLabel)
        self.addSubview(editButton)
    }
    
    func setupConstraints() {
        backgroundButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        routineIndexLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundButton).offset(15)
            $0.leading.equalTo(backgroundButton).offset(19)
        }
        
        routineTitleLabel.snp.makeConstraints {
            $0.top.equalTo(routineIndexLabel.snp.bottom)
            $0.bottom.equalTo(backgroundButton).offset(-18)
            $0.leading.equalTo(backgroundButton).offset(19)
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(backgroundButton).offset(20)
            $0.trailing.equalTo(backgroundButton).offset(-20)
            $0.width.equalTo(65)
            $0.height.equalTo(27)
        }
    }
    
    @objc func backgroundButtonTapped(sender: UIButton!) {
        
        delegate?.didSelectRoutine(index: seletedIndex)
    }
    
    
}


