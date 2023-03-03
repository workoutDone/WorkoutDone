//
//  WorkoutResultView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/03.
//

import UIKit
import Then
import SnapKit

class WorkoutResultView : BaseUIView {
    // MARK: - PROPERTIES
    private let workoutResultLabel = UILabel().then {
        $0.text = "운동 결과"
        $0.textColor = .color121212
        $0.font = .pretendard(.bold, size: 24)
    }
    private let workoutResultBaseView = UIView().then {
        $0.backgroundColor = .colorF8F6FF
        $0.layer.cornerRadius = 12
    }
    private let workoutTimeLabel = UILabel().then {
        $0.textColor = .color7442FF
        $0.text = "운동 시간"
        $0.font = .pretendard(.semiBold, size: 12)
    }
    private let workoutTypeLabel = UILabel().then {
        $0.textColor = .color7442FF
        $0.text = "운동 종목"
        $0.font = .pretendard(.semiBold, size: 12)
    }
    
    override func setupLayout() {
        super.setupLayout()
        addSubview(workoutResultLabel)
        addSubview(workoutResultBaseView)
    }
    override func setupConstraints() {
        super.setupConstraints()
        workoutResultLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
            $0.height.equalTo(26)
        }
        workoutResultBaseView.snp.makeConstraints {
            $0.top.equalTo(workoutResultLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(18)
            $0.height.equalTo(82)
        }
    }
}
