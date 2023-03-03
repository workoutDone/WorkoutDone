//
//  WorkoutView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/03.
//

import UIKit
import Then
import SnapKit

class WorkoutView : BaseUIView {
    // MARK: - PROPERTIES
    private let workoutLabel = UILabel().then {
        $0.text = "운동하기"
        $0.textColor = .color121212
        $0.font = .pretendard(.bold, size: 24)
    }
    private let workoutRoutineBaseView = UIView().then {
        $0.backgroundColor = .colorF8F6FF
        $0.layer.cornerRadius = 12
    }
    private let workoutRoutineInfoLabel = UILabel().then {
        $0.text = "어떤 운동을 할까?"
    }
    private let workoutRoutineChoiceButton = UIButton().then {
        $0.setTitle("루틴 선택", for: .normal)
        $0.titleLabel?.font = .pretendard(.semiBold, size: 16)
        // Todo: 그라데이션 버튼 구현하기
//        $0.backgroundColor = .color
        $0.layer.cornerRadius = 8
    }

    override func setupLayout() {
        super.setupLayout()
        addSubview(workoutLabel)
        addSubview(workoutRoutineBaseView)
        addSubview(workoutRoutineChoiceButton)
        addSubview(workoutRoutineInfoLabel)
    }

    override func setupConstraints() {
        super.setupConstraints()
        workoutLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
            // TOdo: 높이 정확히 알아서 수정하기
            make.height.equalTo(26)
        }
        workoutRoutineBaseView.snp.makeConstraints { make in
            make.top.equalTo(workoutLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(18)
            make.height.equalTo(82)
        }
        workoutRoutineChoiceButton.snp.makeConstraints { make in
            make.centerY.equalTo(workoutRoutineBaseView)
            make.height.equalTo(47)
            // Todo: width값을 어떻게 변경하면 좋을까
            make.width.equalTo(119)
            make.trailing.equalTo(workoutRoutineBaseView.snp.trailing).offset(-14)
        }
        workoutRoutineInfoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(workoutRoutineBaseView)
            make.leading.equalTo(workoutRoutineBaseView.snp.leading).offset(19)
        }
    }
}
