//
//  InputWorkoutDataViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/06/08.
//

import UIKit
import SnapKit
import Then

class InputWorkoutDataViewController : BaseViewController {
    lazy var weightTrainingArrayIndex = 0
    lazy var weightTrainingInfoArrayIndex = 0
    let duringSetViewController = DuringSetViewController()
    // MARK: - PROPERTIES
    
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let effectView = UIVisualEffectView(effect: blurEffect)
        return effectView
    }()
    private let inputDataBackView = UIView().then {
        $0.backgroundColor = .colorFFFFFF
        $0.layer.cornerRadius = 15
    }
    private let setLabel = UILabel().then {
        $0.text = "이 세트는"
        $0.textColor = .color5E5E5E
        $0.font = .pretendard(.regular, size: 18)
    }
    
    private let kgTextField = UITextField().then {
        $0.backgroundColor = UIColor.colorF3F3F3
        $0.layer.cornerRadius = 12
        $0.keyboardType = .decimalPad
    }
    
    private let kgLabel = UILabel().then {
        $0.text = "kg"
        $0.textColor = .color5E5E5E
        $0.font = .pretendard(.regular, size: 18)
    }
    
    private lazy var kgStackView : UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [kgTextField, kgLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .bottom
        stackView.spacing = 5
        return stackView
    }()
    
    private let countTextField = UITextField().then {
        $0.backgroundColor = UIColor.colorF3F3F3
        $0.layer.cornerRadius = 12
        $0.keyboardType = .numberPad
    }
    
    private let countLabel = UILabel().then {
        $0.text = "회"
        $0.textColor = .color5E5E5E
        $0.font = .pretendard(.regular, size: 18)
    }
    
    private lazy var countStackView  : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [countTextField, countLabel])
         stackView.axis = .horizontal
         stackView.distribution = .fill
         stackView.alignment = .bottom
         stackView.spacing = 5
         return stackView
     }()
    private lazy var inputWorkoutStackView  : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [kgStackView, countStackView])
         stackView.axis = .horizontal
         stackView.distribution = .fill
         stackView.alignment = .center
         stackView.spacing = 27
         return stackView
     }()
    let cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(UIColor.color5E5E5E, for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.color929292.cgColor
        $0.layer.borderWidth = 1
        $0.titleLabel?.font = UIFont.pretendard(.semiBold, size: 20)
    }
    
    let okayButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(UIColor.colorFFFFFF, for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.colorF54968.cgColor
        $0.layer.borderWidth = 1
        $0.titleLabel?.font = UIFont.pretendard(.semiBold, size: 20)
        $0.backgroundColor = UIColor.colorF54968
    }
    
    private lazy var buttonStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cancelButton, okayButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 11
        return stackView
    }()
    
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
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
    
    override func setComponents() {
        view.backgroundColor = UIColor(hex: 0x000000, alpha: 0.15)
        visualEffectView.frame = view.frame
    }
    
    override func setupLayout() {
        view.addSubviews(visualEffectView, inputDataBackView)
        inputDataBackView.addSubviews(buttonStackView, setLabel, inputWorkoutStackView)
    }
    override func setupConstraints() {
        inputWorkoutStackView.snp.makeConstraints {
            $0.top.equalTo(setLabel.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }
        kgTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(68)
        }
        countTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(68)
        }
        inputDataBackView.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.height.equalTo(261)
            $0.leading.equalToSuperview().inset(42)
        }
        buttonStackView.snp.makeConstraints {
            $0.height.equalTo(64)
            $0.leading.trailing.bottom.equalToSuperview().inset(15)
        }
        cancelButton.snp.makeConstraints {
            $0.height.equalTo(64)
        }
        okayButton.snp.makeConstraints {
            $0.height.equalTo(64)
        }
        setLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(29)
            $0.height.equalTo(25)
            $0.centerX.equalToSuperview()
        }
    }

    
    // MARK: - ACTIONS
    override func actions() {
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        okayButton.addTarget(self, action: #selector(okayButtonTapped), for: .touchUpInside)
    }
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    @objc func okayButtonTapped() {

        duringSetViewController.dummy.weightTraining[weightTrainingArrayIndex].weightTrainingInfo[weightTrainingInfoArrayIndex].weight = Double(kgTextField.text ?? "")
        duringSetViewController.dummy.weightTraining[weightTrainingArrayIndex].weightTrainingInfo[weightTrainingInfoArrayIndex].traingingCount = Int(countTextField.text ?? "")
        
        duringSetViewController.tableView.reloadData()
        dismiss(animated: true)
        print(duringSetViewController.dummy, "dkdkdk")
        
    }
    @objc func keyboardUp(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            ///화면 사이즈의 중앙과 뷰의 중앙의 차이
            let offsetValue = UIScreen.main.bounds.height / 2 - 261 / 2
            let height = -keyboardSize.height + offsetValue - 22
            if height < 0 {
                self.inputDataBackView.snp.updateConstraints { make in
                    make.centerY.equalToSuperview().offset(height)
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    @objc func keyboardDown() {
        self.inputDataBackView.transform = .identity
    }
}
// MARK: - EXTENSIONs
extension InputWorkoutDataViewController {
    
}

