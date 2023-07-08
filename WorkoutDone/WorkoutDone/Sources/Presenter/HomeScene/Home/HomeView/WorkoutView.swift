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
        $0.textColor = .color929292
        $0.font = .pretendard(.regular, size: 16)
    }
    let workoutRoutineChoiceButton = GradientButton(colors: [UIColor.color7442FF.cgColor, UIColor.color8E36FF.cgColor]).then {
        $0.setTitle("루틴 선택", for: .normal)
        $0.titleLabel?.font = .pretendard(.semiBold, size: 16)
    }
    
    let workoutCompleteBaseView = UIView().then {
        $0.backgroundColor = .colorF8F6FF
        $0.layer.cornerRadius = 12
    }
    private let workoutCompleteLabel = UILabel().then {
        $0.text = "오늘의 운동 완료! \n건강에 한 발짝 더 다가갔어요!"
        $0.font = .pretendard(.semiBold, size: 16)
        $0.textColor = .color7442FF
        $0.numberOfLines = 2
    }
    
    override func setUI() {
        super.setUI()
        workoutCompleteLabel.setLineSpacing(lineHeightMultiple: 1.15)
        workoutCompleteLabel.textAlignment = .center
        workoutCompleteBaseView.isHidden = true
    }
    
    override func setupLayout() {
        super.setupLayout()
        self.addSubviews(workoutLabel, workoutRoutineBaseView, workoutRoutineChoiceButton, workoutRoutineInfoLabel, workoutCompleteBaseView)
        workoutCompleteBaseView.addSubviews(workoutCompleteLabel)
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
        
        workoutCompleteBaseView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(workoutLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(18)
            $0.height.equalTo(82)
        }
        workoutCompleteLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
