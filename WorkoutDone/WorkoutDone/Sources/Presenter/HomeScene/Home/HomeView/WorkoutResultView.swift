//
//  WorkoutResultView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/03.
//

import UIKit
import Then
import SnapKit

final class WorkoutResultView : BaseUIView {
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
    private let workoutTimeBaseView = UIView()
    
    private let workoutTimeTitleLabel = UILabel().then {
        $0.textColor = .color7442FF
        $0.text = "운동 시간"
        $0.font = .pretendard(.semiBold, size: 12)
    }
    let workoutTimeLabel = UILabel().then {
        $0.text = "00:00:00"
        $0.font = .pretendard(.light, size: 22)
        $0.textColor = .color000000
    }
    
    private let workoutTypeBaseView = UIView()
    
    private let workoutTypeTitleLabel = UILabel().then {
        $0.textColor = .color7442FF
        $0.text = "운동 종목"
        $0.font = .pretendard(.semiBold, size: 12)
    }
    let workoutTypeLabel = UILabel().then {
        $0.text = "-"
        $0.textColor = .color000000
        $0.font = .pretendard(.light, size: 22)
    }
    let workoutResultButton = UIButton()
    
    override func setupLayout() {
        super.setupLayout()
        self.addSubviews(workoutResultLabel, workoutResultBaseView, workoutResultButton)
        workoutResultBaseView.addSubviews(workoutTimeBaseView, workoutTypeBaseView)
        workoutTimeBaseView.addSubviews(workoutTimeTitleLabel, workoutTimeLabel)
        workoutTypeBaseView.addSubviews(workoutTypeTitleLabel, workoutTypeLabel)
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
        workoutTimeBaseView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
        }
        workoutTypeBaseView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
        }
        workoutTimeTitleLabel.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.top.equalToSuperview().inset(11)
            $0.leading.equalToSuperview().inset(20)
        }
        workoutTimeLabel.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.top.equalTo(workoutTimeTitleLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
        }
        workoutTypeTitleLabel.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.top.equalToSuperview().inset(11)
            $0.leading.equalToSuperview().inset(20)
        }
        workoutTypeLabel.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.top.equalTo(workoutTypeTitleLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
        }
        workoutResultButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
