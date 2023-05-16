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
    
    let bodyImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.color7442FF.cgColor
        $0.contentMode = .scaleAspectFill
    }
    let workoutDoneCameraButton = UIButton()
    
    private let bodyDataBaseView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .colorFFFFFF
    }
    
    private let bodyInfoView = UIView().then {
        $0.backgroundColor = .colorFFFFFF
        $0.layer.cornerRadius = 10
    }

    private let weightLabel = UILabel().then {
        $0.text = "체중"
        $0.textColor = .color121212
        $0.font = .pretendard(.semiBold, size: 20)
    }
    let weightInputLabel = UILabel().then {
        $0.text = "-"
        $0.textColor = .color7442FF
        $0.font = .pretendard(.medium, size: 20)
        $0.lineBreakMode = .byTruncatingHead
    }
    private let weightUnitLabel = UILabel().then {
        $0.text = "  kg"
        $0.textColor = .color121212
        $0.font = .pretendard(.medium, size: 20)
    }
    private let weightStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 0
    }
    private let weightSeparateView = UIView().then {
        $0.backgroundColor = .colorE6E0FF
    }
    private let skeletalMuscleMassLabel = UILabel().then {
        $0.text = "골격근량"
        $0.textColor = .color121212
        $0.font = .pretendard(.semiBold, size: 20)
    }
    private let skeletalMuscleMassUnitLabel = UILabel().then {
        $0.text = "  kg"
        $0.textColor = .color121212
        $0.font = .pretendard(.medium, size: 20)
    }
    let skeletalMuscleMassInputLabel = UILabel().then {
        $0.text = "-"
        $0.textColor = .color7442FF
        $0.font = .pretendard(.medium, size: 20)
    }
    private let skeletalMusleMassSeparateView = UIView().then {
        $0.backgroundColor = .colorE6E0FF
    }
    private let skelatalMuscleMassStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 0
    }
    
    private let fatPercentageLabel = UILabel().then {
        $0.text = "체지방량"
        $0.textColor = .color121212
        $0.font = .pretendard(.semiBold, size: 20)
    }
    private let fatPercentageUnitLabel = UILabel().then {
        $0.text = "  %"
        $0.textColor = .color121212
        $0.font = .pretendard(.medium, size: 20)
    }
    let fatPercentageInputLabel = UILabel().then {
        $0.text = "-"
        $0.textColor = .color7442FF
        $0.font = .pretendard(.medium, size: 20)
    }
    private let fatPercentageStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 0
    }
    private let fatPercentageSeparateView = UIView().then {
        $0.backgroundColor = .colorE6E0FF
    }
    
    let bodyDataEntryButton = UIButton()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
   
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupLayout() {
        super.setupLayout()
        self.addSubviews(recordLabel, recordView)
        recordView.addSubviews(workoutImageBaseView, bodyInfoView)
        workoutImageBaseView.addSubviews(workoutNotDoneInfoLabel, clickImage, clickAlertLabel, bodyImageView, workoutDoneCameraButton)
        bodyInfoView.addSubviews(weightLabel, weightStackView, weightSeparateView, skeletalMuscleMassLabel, skelatalMuscleMassStackView, skeletalMusleMassSeparateView, fatPercentageLabel, fatPercentageStackView, fatPercentageSeparateView, bodyDataEntryButton)

        [weightInputLabel, weightUnitLabel].forEach {
            weightStackView.addArrangedSubview($0)
        }
        [skeletalMuscleMassInputLabel, skeletalMuscleMassUnitLabel].forEach {
            skelatalMuscleMassStackView.addArrangedSubview($0)
        }

        [fatPercentageInputLabel, fatPercentageUnitLabel].forEach {
            fatPercentageStackView.addArrangedSubview($0)
        }

    }
    override func setupConstraints() {
        super.setupConstraints()
//        [weightUnitLabel, weightInputLabel, weightLabel].forEach {
//            if DeviceManager.shared.isHomeButtonDevice() || DeviceManager.shared.isSimulatorIsHomeButtonDevice() {
//                $0.font = .pretendard(.semiBold, size: 16)
//            }
//        }
//        [skeletalMuscleMassLabel, fatPercentageLabel, skeletalMuscleMassInputLabel, skeletalMuscleMassUnitLabel, fatPercentageInputLabel, fatPercentageUnitLabel].forEach {
//            if DeviceManager.shared.isHomeButtonDevice() || DeviceManager.shared.isSimulatorIsHomeButtonDevice() {
//                $0.font = .pretendard(.semiBold, size: 13)
//            }
//        }
//
        recordLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
            $0.height.equalTo(26)
        }
        recordView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(18)
            $0.top.equalTo(recordLabel.snp.bottom).offset(8)
            $0.height.equalTo(515)
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
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        workoutDoneCameraButton.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        bodyInfoView.snp.makeConstraints {
            $0.height.equalTo(156)
            $0.top.equalTo(workoutImageBaseView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
        }
        weightLabel.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.width.equalTo(35)
            $0.top.equalToSuperview().inset(23)
            $0.leading.equalToSuperview().inset(30)
        }
        weightStackView.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.trailing.equalToSuperview().inset(30)
            $0.top.equalToSuperview().inset(23)
        }
        weightSeparateView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(weightLabel.snp.bottom).offset(3)
        }
        skeletalMuscleMassLabel.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.leading.equalToSuperview().inset(30)
            $0.top.equalTo(weightSeparateView.snp.bottom).offset(13)
        }
        skelatalMuscleMassStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(26)
            $0.top.equalTo(weightSeparateView.snp.bottom).offset(13)
        }
        skeletalMusleMassSeparateView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(skeletalMuscleMassLabel.snp.bottom).offset(3)
        }
        fatPercentageLabel.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.leading.equalToSuperview().inset(30)
            $0.top.equalTo(skeletalMusleMassSeparateView.snp.bottom).offset(13)
        }
        fatPercentageStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(26)
            $0.top.equalTo(skeletalMusleMassSeparateView.snp.bottom).offset(13)
        }
        fatPercentageSeparateView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(fatPercentageLabel.snp.bottom).offset(3)
        }
        bodyDataEntryButton.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
