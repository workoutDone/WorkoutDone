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
}
