//
//  TodayEmptyWorkoutResultView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/06/13.
//

import UIKit
import Then
import SnapKit

final class TodayEmptyWorkoutResultView : BaseUIView {
    private let titleLabel = UILabel().then {
        $0.text = "오늘의 운동 기록이 없습니다."
        $0.textColor = .color929292
        $0.font = .pretendard(.regular, size: 16)
    }
    
    override func setupLayout() {
        super.setupLayout()
        self.addSubview(titleLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(102)
            $0.centerX.equalToSuperview()
        }
    }
}
