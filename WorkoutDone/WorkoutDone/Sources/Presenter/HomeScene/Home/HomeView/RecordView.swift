//
//  RecordView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/03.
//

import UIKit
import Then
import SnapKit
import DeviceKit


//Todo: - 몸무게, 체지방량, 근골격량 길이 길어질 때 처리하기

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
        $0.image = UIImage(named: "clickImage")
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
    let workoutDoneCameraButton = UIButton()
    
    private let bodyDataBaseView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .colorFFFFFF
    }
    private let bodyDataEntryButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.setImage(UIImage(named: "pencil"), for: .normal)
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .colorFFFFFF
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
        $0.text = "1200"
        $0.textColor = .color7442FF
        $0.font = .pretendard(.semiBold, size: 22)
        $0.lineBreakMode = .byTruncatingHead
    }
    private let weightUnitLabel = UILabel().then {
        $0.text = " kg"
        $0.textColor = .color121212
        $0.font = .pretendard(.semiBold, size: 22)
    }
    private let skeletalMuscleMassLabel = UILabel().then {
        $0.text = "골격근량"
        $0.textColor = .color121212
        $0.font = .pretendard(.semiBold, size: 16)
    }
    private let skeletalMuscleMassUnitLabel = UILabel().then {
        $0.text = " kg"
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
    private let weightStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 0
    }
    private let skelatalMuscleMassAndFatPercentageLabelStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 0
    }
    private let skelatalMuscleMassStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 0
    }
    private let fatPercentageStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 0
    }
    private let skelatalMuscleMassAndFatPercentageValueStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 0
    }
    
    override func setupLayout() {
        super.setupLayout()
        [recordLabel, recordView, workoutImageBaseView, workoutNotDoneInfoLabel, clickImage, clickAlertLabel, bodyInfoView, workoutDoneCameraButton, bodyDataBaseView, bodyDataEntryButton, bodyInfoView, separateView, weightLabel, weightStackView, skelatalMuscleMassAndFatPercentageLabelStackView, skelatalMuscleMassAndFatPercentageValueStackView, bodyImageView].forEach {
            addSubview($0)
        }
        [weightInputLabel, weightUnitLabel].forEach {
            weightStackView.addArrangedSubview($0)
        }
        [fatPercentageLabel, skeletalMuscleMassLabel].forEach {
            skelatalMuscleMassAndFatPercentageLabelStackView.addArrangedSubview($0)
        }
        [skeletalMuscleMassInputLabel, skeletalMuscleMassUnitLabel].forEach {
            skelatalMuscleMassStackView.addArrangedSubview($0)
        }
        [fatPercentageInputLabel, fatPercentageUnitLabel].forEach {
            fatPercentageStackView.addArrangedSubview($0)
        }
        [fatPercentageStackView, skelatalMuscleMassStackView].forEach {
            skelatalMuscleMassAndFatPercentageValueStackView.addArrangedSubview($0)
        }
    }
    override func setupConstraints() {
        super.setupConstraints()
        [weightUnitLabel, weightInputLabel, weightLabel].forEach {
            if DeviceManager.shared.isHomeButtonDevice() || DeviceManager.shared.isSimulatorIsHomeButtonDevice() {
                $0.font = .pretendard(.semiBold, size: 16)
            }
        }
        [skeletalMuscleMassLabel, fatPercentageLabel, skeletalMuscleMassInputLabel, skeletalMuscleMassUnitLabel, fatPercentageInputLabel, fatPercentageUnitLabel].forEach {
            if DeviceManager.shared.isHomeButtonDevice() || DeviceManager.shared.isSimulatorIsHomeButtonDevice() {
                $0.font = .pretendard(.semiBold, size: 13)
            }
        }
        
        recordLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
            $0.height.equalTo(26)
        }
        recordView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(18)
            $0.top.equalTo(recordLabel.snp.bottom).offset(8)
            $0.height.equalTo(445)
        }
        workoutImageBaseView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(recordView.snp.leading).offset(12)
            $0.top.equalTo(recordView.snp.top).offset(13)
            $0.height.equalTo(318)
        }
        workoutNotDoneInfoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(44)
            $0.top.equalTo(workoutImageBaseView.snp.top).offset(58)
        }
        clickImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(workoutNotDoneInfoLabel.snp.bottom).offset(31)
            $0.height.width.equalTo(41)
        }
        clickAlertLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(26)
            $0.top.equalTo(clickImage.snp.bottom).offset(7)
        }
        bodyImageView.snp.makeConstraints {
            $0.top.equalTo(workoutImageBaseView.snp.top).offset(0)
            $0.leading.equalTo(workoutImageBaseView.snp.leading).offset(0)
            $0.trailing.equalTo(workoutImageBaseView.snp.trailing).offset(0)
            $0.bottom.equalTo(workoutImageBaseView.snp.bottom).offset(0)
        }
        workoutDoneCameraButton.snp.makeConstraints {
            $0.top.equalTo(bodyImageView.snp.top).offset(0)
            $0.leading.equalTo(bodyImageView.snp.leading).offset(0)
            $0.trailing.equalTo(bodyImageView.snp.trailing).offset(0)
            $0.bottom.equalTo(bodyImageView.snp.bottom).offset(0)
        }
        
        ///바디 정보 입력 뷰
        bodyInfoView.snp.makeConstraints {
            $0.top.equalTo(workoutImageBaseView.snp.bottom).offset(16)
            $0.leading.equalTo(recordView.snp.leading).offset(12)
            $0.bottom.equalTo(recordView.snp.bottom).offset(-13)
            $0.trailing.equalTo(bodyDataEntryButton.snp.leading).offset(-9)
        }
        ///바디 정보 구분 선 뷰
        separateView.snp.makeConstraints {
            $0.top.equalTo(bodyInfoView.snp.top).offset(8)
            $0.centerX.centerY.equalTo(bodyInfoView)
            $0.width.equalTo(0.5)
        }
        bodyDataEntryButton.snp.makeConstraints {
            $0.top.equalTo(workoutImageBaseView.snp.bottom).offset(16)
            $0.trailing.equalTo(recordView.snp.trailing).offset(-12)
            $0.bottom.equalTo(recordView.snp.bottom).offset(-13)
            $0.width.equalTo(51)
        }
        ///체중 라벨
        weightLabel.snp.makeConstraints {
            $0.centerY.equalTo(bodyInfoView)
            $0.leading.equalTo(bodyInfoView.snp.leading).offset(20)
        }
        ///체중 입력
        weightStackView.snp.makeConstraints {
            $0.centerY.equalTo(bodyInfoView)
            $0.trailing.equalTo(separateView.snp.leading).offset(-8)
            $0.leading.greaterThanOrEqualTo(weightLabel.snp.trailing).offset(8)
        }
        skeletalMuscleMassLabel.snp.makeConstraints {
            $0.height.equalTo(26)
        }
        skeletalMuscleMassInputLabel.snp.makeConstraints {
            $0.height.equalTo(26)
        }
        skeletalMuscleMassUnitLabel.snp.makeConstraints {
            $0.height.equalTo(26)
        }
        fatPercentageLabel.snp.makeConstraints {
            $0.height.equalTo(26)
        }
        fatPercentageInputLabel.snp.makeConstraints {
            $0.height.equalTo(26)
        }
        fatPercentageUnitLabel.snp.makeConstraints {
            $0.height.equalTo(26)
        }
        skelatalMuscleMassAndFatPercentageLabelStackView.snp.makeConstraints {
            $0.centerY.equalTo(bodyInfoView)
            $0.leading.equalTo(separateView.snp.trailing).offset(14)
            
        }
        skelatalMuscleMassAndFatPercentageValueStackView.snp.makeConstraints {
            $0.centerY.equalTo(bodyInfoView)
            $0.trailing.equalTo(bodyInfoView.snp.trailing).offset(-19)
        }
        
    }
}
