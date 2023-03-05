//
//  RecordView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/03.
//

import UIKit
import Then
import SnapKit

class RecordView : BaseUIView {
    // MARK: - PROPERTIES
    private let recordLabel = UILabel().then {
        $0.text = "기록하기"
        $0.textColor = .color121212
        $0.font = .pretendard(.bold, size: 24)
    }
    private let recordView = UIView().then {
        $0.backgroundColor = .colorF8F6FF
        $0.layer.cornerRadius = 12
    }
    private let workoutImageBaseView = UIView().then {
        $0.backgroundColor = .colorE6E0FF
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.color7442FF.cgColor
    }
    private let workoutNotDoneInfoLabel = UILabel().then {
        $0.text = "아직 오늘의 운동 사진이 없습니다. \n운동을 하고 인증을 해 봅시다!"
        $0.textColor = .color929292
        $0.textAlignment = .center
        $0.font = .pretendard(.regular, size: 14)
        $0.numberOfLines = 2
    }
    private let clickImage = UIImageView().then {
        $0.image = UIImage(named: "")
        $0.contentMode = .scaleAspectFill
    }
    private let clickAlertLabel = UILabel().then {
        $0.text = "오늘의 운동을 마쳤다면 클릭!"
        $0.textColor = .color7442FF
        $0.font = .pretendard(.regular, size: 16)
    }
    
    private let bodyImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.color7442FF.cgColor
    }
    private let workoutDoneCameraButton = UIButton()
    
    private let bodyDataBaseView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .colorFFFFFF
    }
    private let bodyDataEntryButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.setImage(UIImage(named: ""), for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color7442FF.cgColor
    }
    private let bodyInfoView = UIView().then {
        $0.backgroundColor = .colorFFFFFF
        $0.layer.cornerRadius = 10
    }
    private let separateView = UIView().then {
        $0.backgroundColor = .colorC884FF
    }
    private let weightLabel = UILabel().then {
        $0.text = "체중"
        $0.textColor = .color121212
        $0.font = .pretendard(.semiBold, size: 22)
    }
    private let weightInputLabel = UILabel().then {
        $0.text = "120"
        $0.textColor = .color7442FF
        $0.font = .pretendard(.semiBold, size: 22)
    }
    private let weightUnitLabel = UILabel().then {
        $0.text = "kg"
        $0.textColor = .color121212
        $0.font = .pretendard(.semiBold, size: 22)
    }
    private let skeletalMuscleMassLabel = UILabel().then {
        $0.text = "골격근량"
        $0.textColor = .color121212
        $0.font = .pretendard(.semiBold, size: 16)
    }
    private let skeletalMuscleMassUnitLabel = UILabel().then {
        $0.text = "kg"
        $0.textColor = .color121212
        $0.font = .pretendard(.medium, size: 16)
    }
    private let skeletalMuscleMassInputLabel = UILabel().then {
        $0.text = "28"
        $0.textColor = .color7442FF
        $0.font = .pretendard(.medium, size: 16)
    }
    private let fatPercentageLabel = UILabel().then {
        $0.text = "체지방량"
        $0.textColor = .color121212
        $0.font = .pretendard(.semiBold, size: 16)
    }
    private let fatPercentageUnitLabel = UILabel().then {
        $0.text = "%"
        $0.textColor = .color121212
        $0.font = .pretendard(.medium, size: 16)
    }
    private let fatPercentageInputLabel = UILabel().then {
        $0.text = "20"
        $0.textColor = .color7442FF
        $0.font = .pretendard(.medium, size: 16)
    }
    
    override func setupLayout() {
        super.setupLayout()
        [recordLabel, recordView, workoutImageBaseView, workoutNotDoneInfoLabel, clickImage, clickAlertLabel, bodyInfoView, workoutDoneCameraButton, bodyDataBaseView, bodyDataEntryButton, bodyInfoView, separateView].forEach {
            addSubview($0)
        }
    }
    override func setupConstraints() {
        super.setupConstraints()
    }
}
