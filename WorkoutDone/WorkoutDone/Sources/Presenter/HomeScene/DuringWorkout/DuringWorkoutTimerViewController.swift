//
//  DuringWorkoutTimerViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/26.
//

import UIKit

class DuringWorkoutTimerViewController : BaseViewController {
    let timeArray = Array(0...59)
    var countdownSeconds : Int = 0
    var countdownMinutes : Int = 0
    var countDownTimeValue : Int = 0
    
    var completionHandler : ((Int) -> (Void))?
    // MARK: - PROPERTIES
    private let timerBackView = UIView().then {
        $0.backgroundColor = .colorFFFFFF
        $0.layer.cornerRadius = 15
    }
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let effectView = UIVisualEffectView(effect: blurEffect)
        return effectView
    }()
    
    private let pickerBackView = UIView()
    
    private let minutesPickerView = UIPickerView()
    
    private let dotLabel = UILabel().then {
        $0.text = ":"
        $0.textColor = .color121212
        $0.font = .pretendard(.medium, size: 36)
    }
    
    private let secondsPickerView = UIPickerView()
    
    private lazy var timerStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [minutesPickerView, dotLabel, secondsPickerView])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 18
        return stackView
    }()
    private let minutesLabel = UILabel().then {
        $0.text = "분"
        $0.font = UIFont.pretendard(.regular, size: 16)
        $0.textColor = .color5E5E5E
    }
    
    private let secondsLabel = UILabel().then {
        $0.text = "초"
        $0.font = UIFont.pretendard(.regular, size: 16)
        $0.textColor = .color5E5E5E
    }
    
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
        minutesPickerView.delegate = self
        secondsPickerView.delegate = self
    }
    override func viewWillLayoutSubviews() {
        minutesPickerView.subviews[1].backgroundColor = .clear
        secondsPickerView.subviews[1].backgroundColor = .clear
    }
    
    override func setComponents() {
        view.backgroundColor = UIColor(hex: 0x000000, alpha: 0.15)
        visualEffectView.frame = view.frame
    }
    override func setupLayout() {
        view.addSubviews(visualEffectView, timerBackView)
        timerBackView.addSubviews(buttonStackView, minutesLabel, secondsLabel, pickerBackView)
        pickerBackView.addSubview(timerStackView)
    }
    override func setupConstraints() {
        timerBackView.snp.makeConstraints {
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
        minutesLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(27)
            $0.centerX.equalTo(minutesPickerView)
        }
        secondsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(27)
            $0.centerX.equalTo(secondsPickerView)
        }
        pickerBackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(cancelButton.snp.top)
        }
        
        timerStackView.snp.makeConstraints {
            $0.top.bottom.centerX.top.equalToSuperview()
            
        }
        minutesPickerView.snp.makeConstraints {
            $0.width.equalTo(70)
        }
        secondsPickerView.snp.makeConstraints {
            $0.width.equalTo(70)
        }
    }
    
    // MARK: - ACTIONS
    override func actions() {
        super.actions()
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        okayButton.addTarget(self, action: #selector(okayButtonTapped), for: .touchUpInside)
    }
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    @objc func okayButtonTapped() {
        dismiss(animated: true)
        print(countdownMinutes, "분")
        print(countdownSeconds, "초")
        countDownTimeValue = countdownMinutes * 60 + countdownSeconds
        print(countDownTimeValue, "이걸루")
        completionHandler?(countDownTimeValue)
    }
}
// MARK: - EXTENSIONs
extension DuringWorkoutTimerViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(timeArray[row])
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case minutesPickerView:
            countdownMinutes = Int(timeArray[row])
        case secondsPickerView:
            countdownSeconds = Int(timeArray[row])
        default:
            countdownMinutes = 0
            countdownSeconds = 0
        }
    }


}

