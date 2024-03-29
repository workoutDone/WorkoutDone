//
//  CreateRoutineCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/29.
//

import UIKit

class CreateRoutineCell: UITableViewCell {
    private let borderImage = UIImageView().then {
        $0.image = UIImage(named: "border")
    }
    
    private let emptyRoutineLabel = UILabel().then {
        $0.text = "나의 루틴이 없어요!"
        $0.textColor = .color929292
        $0.font = .pretendard(.regular, size: 15)
    }
    
    private let createRoutineLabel = UILabel().then {
        $0.text = "새로운 루틴을 만들어 가볼까요?"
        $0.textColor = .color929292
        $0.font = .pretendard(.medium, size: 15)
    }
    
    private let createRoutineImage = UIImageView().then {
        $0.image = UIImage(named: "createRoutine")
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

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 27, bottom: 0, right: 27))
    }

    
    // MARK: - ACTIONS
    func setupLayout() {
        [borderImage, emptyRoutineLabel, createRoutineLabel, createRoutineImage].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        borderImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(127)
        }
        
        emptyRoutineLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(25)
            $0.centerX.equalToSuperview()
        }
        
        createRoutineLabel.snp.makeConstraints {
            $0.top.equalTo(emptyRoutineLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        createRoutineImage.snp.makeConstraints {
            $0.top.equalTo(createRoutineLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(32)
        }
    }
}
