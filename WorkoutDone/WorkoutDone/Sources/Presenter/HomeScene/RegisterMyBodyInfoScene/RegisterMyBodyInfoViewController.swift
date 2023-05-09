//
//  RegisterMyBodyInfoViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/10.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

struct BodyInputData {
    var weight : String?
    var skeletalMusleMass : String?
    var fatPercentage : String?
}


class RegisterMyBodyInfoViewController : BaseViewController {
    // MARK: - ViewModel
    private var viewModel = RegisterMyBodyInfoViewModel()
    
    private var bodyInputData = PublishSubject<BodyInputData>()
    var selectedDate : Int?
    private var didLoad = PublishSubject<Void>()
    private lazy var input = RegisterMyBodyInfoViewModel.Input(
        loadView: didLoad.asDriver(onErrorJustReturn: ()),
        weightInputText: weightTextField.rx.text.orEmpty.asDriver(),
        skeletalMusleMassInputText: skeletalMuscleMassTextField.rx.text.orEmpty.asDriver(),
        fatPercentageInputText: fatPercentageTextField.rx.text.orEmpty.asDriver(),
        saveButtonTapped: bodyInputData.asDriver(onErrorJustReturn: BodyInputData(weight: "", skeletalMusleMass: "", fatPercentage: "")),
        selectedDate: Driver.just(selectedDate!)
    )
    private lazy var output = viewModel.transform(input: input)
    
    ///dismiss 시 사용될 CompletionHandler
    var completionHandler : ((Int) -> Void)?
    
    // MARK: - PROPERTIES
    private let baseView = UIView().then {
        $0.backgroundColor = .colorFFFFFF
        $0.layer.cornerRadius = 15
    }
    private let cancelButton = UIButton().then {
        $0.setImage(UIImage(named: "xImage"), for: .normal)
        $0.backgroundColor = .colorF3F3F3
        $0.layer.cornerRadius = 6
    }
    private let saveButton = GradientButton(colors: [UIColor.color7442FF.cgColor, UIColor.color8E36FF.cgColor]).then {
        $0.setTitle("저장히기", for: .normal)
        $0.setTitleColor(.colorFFFFFF, for: .normal)
        $0.titleLabel?.font = .pretendard(.semiBold, size: 20)
    }
    private let myBodyInfoLabel = UILabel().then {
        $0.text = "나의 신체 정보"
        $0.textColor = .color000000
        $0.font = .pretendard(.bold, size: 20)
    }
    private let wegihtLabel = UILabel().then {
        $0.text = "체중"
        $0.textAlignment = .right
        $0.font = .pretendard(.bold, size: 18)
        $0.textColor = .color000000
    }
    private let weightTextField = UITextField().then {
        $0.backgroundColor = .colorF3F3F3
        // MARK: - TODO 기본설정 잡기
        $0.layer.cornerRadius = 8
        $0.textAlignment = .right
        $0.keyboardType = .numberPad
    }
    private let weightUnitLabel = UILabel().then {
        $0.text = "KG"
        $0.textColor = .color000000
        $0.textAlignment = .left
        $0.font = .pretendard(.medium, size: 18)
    }
    private let skeletalMuscleMassLabel = UILabel().then {
        $0.text = "골격근량"
        $0.textAlignment = .right
        $0.textColor = .color000000
        $0.font = .pretendard(.bold, size: 18)
    }
    private let skeletalMuscleMassTextField = UITextField().then {
        $0.backgroundColor = .colorF3F3F3
        // MARK: - TODO 기본설정 잡기
        $0.layer.cornerRadius = 8
        $0.textAlignment = .right
        $0.keyboardType = .numberPad
    }
    private let skeletalMuscleMassUnitLabel = UILabel().then {
        $0.text = "KG"
        $0.textAlignment = .left
        $0.textColor = .color000000
        $0.font = .pretendard(.medium, size: 18)
    }
    
    private let fatPercentageLabel = UILabel().then {
        $0.text = "체지방률"
        $0.textAlignment = .right
        $0.textColor = .color000000
        $0.font = .pretendard(.bold, size: 18)
    }
    private let fatPercentageTextField = UITextField().then {
        $0.backgroundColor = .colorF3F3F3
        // MARK: - TODO 기본설정 잡기
        $0.layer.cornerRadius = 8
        $0.textAlignment = .right
        $0.keyboardType = .numberPad
    }
    private let fatPercentageUnitLabel = UILabel().then {
        $0.text = "%"
        $0.textAlignment = .left
        $0.textColor = .color000000
        $0.font = .pretendard(.medium, size: 18)
    }
    private let weightInputStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 13
    }
    private let weightStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 47
    }
    private let skeletalMuscleMassInputStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 13
    }
    private let skeletalMuscleMassStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 47
    }
    private let fatPercentageInputStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 13
    }
    private let fatPercentageStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 47
    }
    // MARK: - LIFECYCLE
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func setupLayout() {
        super.setupLayout()
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let visualEffetView = UIVisualEffectView(effect: blurEffect)
        view.backgroundColor = UIColor(hex: 0x000000, alpha: 0.15)
        visualEffetView.frame = view.frame
        [visualEffetView, baseView, saveButton, myBodyInfoLabel, weightStackView, skeletalMuscleMassStackView, fatPercentageStackView, cancelButton].forEach {
            view.addSubview($0)
        }
        [weightTextField, weightUnitLabel].forEach {
            weightInputStackView.addArrangedSubview($0)
        }
        [wegihtLabel, weightInputStackView].forEach {
            weightStackView.addArrangedSubview($0)
        }
        [skeletalMuscleMassTextField, skeletalMuscleMassUnitLabel].forEach {
            skeletalMuscleMassInputStackView.addArrangedSubview($0)
        }
        [skeletalMuscleMassLabel, skeletalMuscleMassInputStackView].forEach {
            skeletalMuscleMassStackView.addArrangedSubview($0)
        }
        [fatPercentageTextField, fatPercentageUnitLabel].forEach {
            fatPercentageInputStackView.addArrangedSubview($0)
        }
        [fatPercentageLabel, fatPercentageInputStackView].forEach {
            fatPercentageStackView.addArrangedSubview($0)
        }
    }


    override func setupConstraints() {
        super.setupConstraints()
        [weightTextField, fatPercentageTextField, skeletalMuscleMassTextField].forEach {
            $0.addRightPadding()
            $0.addLeftPadding()
        }
        baseView.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(346)
        }
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(baseView.snp.top).offset(12)
            $0.trailing.equalTo(baseView.snp.trailing).offset(-12)
            $0.height.width.equalTo(28)
        }
        myBodyInfoLabel.snp.makeConstraints {
            $0.centerX.equalTo(baseView)
            $0.top.equalTo(baseView.snp.top).offset(31)
        }
        [wegihtLabel, skeletalMuscleMassLabel, fatPercentageLabel].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(63)
            }
        }
        [weightUnitLabel, skeletalMuscleMassUnitLabel, fatPercentageUnitLabel].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(24)
            }
        }
        ///체중
        weightStackView.snp.makeConstraints {
            $0.centerX.equalTo(baseView)
            $0.top.equalTo(myBodyInfoLabel.snp.bottom).offset(36)
        }
        weightTextField.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.width.equalTo(101)
        }
        ///골격근량
        skeletalMuscleMassStackView.snp.makeConstraints {
            $0.centerX.equalTo(baseView)
            $0.top.equalTo(weightStackView.snp.bottom).offset(22)
        }
        skeletalMuscleMassTextField.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.width.equalTo(101)
        }
        saveButton.snp.makeConstraints {
            $0.centerX.equalTo(baseView)
            $0.leading.equalTo(baseView.snp.leading).offset(16)
            $0.bottom.equalTo(baseView.snp.bottom).offset(-16)
            $0.height.equalTo(58)
        }
        ///체지방량
        fatPercentageStackView.snp.makeConstraints {
            $0.centerX.equalTo(baseView)
            $0.top.equalTo(skeletalMuscleMassStackView.snp.bottom).offset(22)
        }
        fatPercentageTextField.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.width.equalTo(101)
        }
    }
    override func setupBinding() {
        super.setupBinding()
        output.weightOutputText.drive(weightTextField.rx.text)
            .disposed(by: disposeBag)
        output.skeletalMusleMassOutputText.drive(skeletalMuscleMassTextField.rx.text)
            .disposed(by: disposeBag)
        output.fatPercentageOutputText.drive(fatPercentageTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.saveData.drive(onNext: {
            self.dismiss(animated: true)
            self.completionHandler?(self.selectedDate!)
        })
            .disposed(by: disposeBag)
        
        output.readWeightData.drive(weightTextField.rx.text)
            .disposed(by: disposeBag)
        output.readSkeletalMusleMassData.drive(skeletalMuscleMassTextField.rx.text)
            .disposed(by: disposeBag)
        output.readFatPercentageData.drive(fatPercentageTextField.rx.text)
            .disposed(by: disposeBag)
        
        
        didLoad.onNext(())
        saveButton.rx.tap
            .bind { value in
                print(value, "버튼 탭")
                self.bodyInputData.onNext(BodyInputData(
                    weight: self.weightTextField.text ?? "",
                    skeletalMusleMass: self.skeletalMuscleMassTextField.text ?? "",
                    fatPercentage: self.fatPercentageTextField.text ?? ""))
            }
            .disposed(by: disposeBag)
        
        
        
    }
    override func actions() {
        super.actions()
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    @objc func keyboardUp(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            ///화면 사이즈의 중앙과 뷰의 중앙의 차이
            let offsetValue = UIScreen.main.bounds.height / 2 - 346 / 2
            let height = -keyboardSize.height + offsetValue
            if height < 0 {
                self.baseView.snp.updateConstraints { make in
                    make.centerY.equalToSuperview().offset(height)
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    @objc func keyboardDown() {
        self.baseView.transform = .identity
    }
    
}
