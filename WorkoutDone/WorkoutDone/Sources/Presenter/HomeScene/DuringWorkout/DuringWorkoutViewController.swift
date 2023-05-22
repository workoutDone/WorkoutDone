//
//  DuringWorkoutViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/19.
//

import UIKit

class DuringWorkoutViewController : BaseViewController {
    
    lazy var foldedViewHeight = 70.0
    lazy var expandedViewHeight = 92.0
    
    
    // MARK: - PROPERTIES
    private let currentWorkoutLabel = UILabel().then {
        $0.font = .pretendard(.semiBold, size: 20)
        $0.text = "뎀벨프레스"
        $0.textColor = .color000000
    }
    private let foldedworkoutTimeLabel = UILabel().then {
        $0.text = "00:08:34"
        $0.textColor = .color000000
        $0.font = .pretendard(.regular, size: 16)
    }

    
    private let endWorkoutButton = RightBarButtonItem(title: "운동 종료", buttonBackgroundColor: .colorFFEDF0, titleColor: .colorF54968).then {
        $0.layer.opacity = 0
        $0.layer.cornerRadius = 5
    }
    
    
    let foldViewToggleButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.up", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .bold)), for: .normal)
        
    }
    private let foldedPlayButton = UIButton().then {
        $0.setImage(UIImage(systemName: "play.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 41, weight: .bold)), for: .normal)
        $0.layer.opacity = 1
    }

    private let workoutPlayView = UIView().then {
        $0.backgroundColor = .colorF8F6FF
        $0.layer.opacity = 0
        $0.layer.cornerRadius = 42
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.colorE6E0FF.cgColor
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private let expandedPlayButton = UIButton().then {
        $0.setImage(UIImage(systemName: "play.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 41, weight: .bold)), for: .normal)
        $0.layer.opacity = 0
    }
    private let playButtonTitleLabel = UILabel().then {
        $0.text = "운동 재개"
        $0.font = .pretendard(.semiBold, size: 14)
        $0.textColor = .color7442FF
        $0.layer.opacity = 0
    }
    
    
    private let nextWorkoutButton = UIButton().then {
        $0.setImage(UIImage(systemName: "play.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .bold)), for: .normal)
        $0.layer.opacity = 0
    }
    
    private let nextWorkoutButtonTitleLabel = UILabel().then {
        $0.text = "다음 운동"
        $0.font = .pretendard(.regular, size: 14)
        $0.textColor = .color7442FF
        $0.layer.opacity = 0
    }
    
    private let previousWorkoutButton = UIButton().then {
        $0.setImage(UIImage(systemName: "play.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .bold)), for: .normal)
        $0.layer.opacity = 0
    }
    
    private let previousWorkoutButtonTitleLabel = UILabel().then {
        $0.text = "이전 운동"
        $0.font = .pretendard(.regular, size: 14)
        $0.textColor = .color7442FF
        $0.layer.opacity = 0
    }
    
    private let restButton = UIButton().then {
        $0.setTitle("휴식하기", for: .normal)
        $0.setTitleColor(UIColor.colorFFFFFF, for: .normal)
        $0.backgroundColor = .colorF54968
        $0.layer.cornerRadius = 12
        $0.titleLabel?.font = .pretendard(.bold, size: 16)
        $0.layer.opacity = 0
    }
    
    private let restTimeLeftLabel = UILabel().then {
        $0.text = "남은 휴식시간"
        $0.font = .pretendard(.regular, size: 14)
        $0.textColor = .colorF54968
        $0.layer.opacity = 0
    }
    
    private let restTimerUnderBarView = UIView().then {
        $0.backgroundColor = .colorF54968
        $0.layer.opacity = 0
    }
    private let restTimerLabel = UILabel().then {
        $0.text = "00:01:29"
        $0.font = .pretendard(.semiBold, size: 24)
        $0.textColor = .colorF54968
        $0.layer.opacity = 0
    }
    
    
    private let currentWorkoutView = UIView().then {
        $0.layer.opacity = 0
    }
    
    private let currentWorkoutTitleLabel = UILabel().then {
        $0.text = "현재 운동"
        $0.font = .pretendard(.regular, size: 14)
        $0.textColor = .color7442FF
        $0.layer.opacity = 0
    }
    
    private let expandedTotalWorkoutTimeTitleLabel = UILabel().then {
        $0.text = "총 운동 시간"
        $0.textColor = .color121212
        $0.font = .pretendard(.regular, size: 12)
        $0.layer.opacity = 0
    }
    
    private let expandedTotalWorkoutTimeLabel = UILabel().then {
        $0.text = "00:08:34"
        $0.textColor = .color121212
        $0.font = .pretendard(.semiBold, size: 20)
        $0.layer.opacity = 0
    }
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    override func setupBinding() {
        
    }
    
    func setupUI() {
        view.addSubviews(currentWorkoutLabel, foldedworkoutTimeLabel, foldedPlayButton, foldViewToggleButton, endWorkoutButton, workoutPlayView, restButton, restTimerUnderBarView, restTimerLabel, restTimeLeftLabel, currentWorkoutView)
        workoutPlayView.addSubviews(expandedPlayButton, playButtonTitleLabel, nextWorkoutButton, nextWorkoutButtonTitleLabel, previousWorkoutButton, previousWorkoutButtonTitleLabel)
        
        currentWorkoutView.addSubviews(currentWorkoutTitleLabel, expandedTotalWorkoutTimeTitleLabel, expandedTotalWorkoutTimeLabel)
        view.layer.opacity = 1
        
        view.frame = CGRect(x: 0, y: view.frame.height - (foldedViewHeight + 82), width: view.frame.width, height: foldedViewHeight)
        view.clipsToBounds = true
        view.backgroundColor = .colorFFFFFF
        currentWorkoutLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(56)
        }
        foldedworkoutTimeLabel.snp.makeConstraints {
//            $0.top.equalTo(currentWorkoutLabel.snp.bottom).offset(2)
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(56)
        }
        foldedPlayButton.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(14)
            $0.height.width.equalTo(41)
            $0.trailing.equalTo(view.snp.trailing).offset(-20)
        }
        endWorkoutButton.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(14)
            $0.width.equalTo(80)
            $0.height.equalTo(30)
            $0.trailing.equalTo(view.snp.trailing).offset(-14)
        }
        foldViewToggleButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.equalTo(20)
            $0.width.equalTo(16)
            $0.height.equalTo(9)
        }
        workoutPlayView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(96)
        }
        expandedPlayButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(46)
        }
        playButtonTitleLabel.snp.makeConstraints {
            $0.top.equalTo(expandedPlayButton.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
        nextWorkoutButton.snp.makeConstraints {
            $0.leading.equalTo(expandedPlayButton.snp.trailing).offset(66)
            $0.centerY.equalTo(expandedPlayButton.snp.centerY)
        }
        nextWorkoutButtonTitleLabel.snp.makeConstraints {
            $0.top.equalTo(nextWorkoutButton.snp.bottom).offset(4)
            $0.centerX.equalTo(nextWorkoutButton)
        }
        previousWorkoutButton.snp.makeConstraints {
            $0.trailing.equalTo(expandedPlayButton.snp.leading).offset(-66)
            $0.centerY.equalTo(expandedPlayButton.snp.centerY)
        }
        previousWorkoutButtonTitleLabel.snp.makeConstraints {
            $0.top.equalTo(previousWorkoutButton.snp.bottom).offset(4)
            $0.centerX.equalTo(previousWorkoutButton)
        }
        restButton.snp.makeConstraints {
            $0.width.equalTo(148)
            $0.height.equalTo(45)
            $0.trailing.equalToSuperview().inset(50)
            $0.bottom.equalTo(workoutPlayView.snp.top).offset(-30)
        }
        restTimerUnderBarView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.width.equalTo(103)
            $0.bottom.equalTo(workoutPlayView.snp.top).offset(-30)
            $0.leading.equalToSuperview().inset(53)
        }
        restTimerLabel.snp.makeConstraints {
            $0.bottom.equalTo(restTimerUnderBarView.snp.top).offset(-2)
            $0.centerX.equalTo(restTimerUnderBarView)
        }
        restTimeLeftLabel.snp.makeConstraints {
            $0.bottom.equalTo(restTimerLabel.snp.top).offset(-8)
            $0.centerX.equalTo(restTimerUnderBarView)
        }
        
        
        currentWorkoutView.snp.makeConstraints {
            $0.top.equalTo(endWorkoutButton.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(71)
        }
        currentWorkoutTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(26)
        }
        expandedTotalWorkoutTimeTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(26)
        }
        expandedTotalWorkoutTimeLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(9)
            $0.trailing.equalToSuperview().inset(26)
        }
    }
    
    override func setupLayout() {
//        view.addSubviews(workoutPlayView)
        
    }
    override func setComponents() {

    }
    override func setupConstraints() {

    }

    
    // MARK: - ACTIONS
    override func actions() {
        super.actions()

        foldViewToggleButton.addTarget(self, action: #selector(foldViewToggleButtonTapped), for: .touchUpInside)
        endWorkoutButton.addTarget(self, action: #selector(endWorkoutButtonTapped), for: .touchUpInside)

    }
    @objc func foldViewToggleButtonTapped() {
        print("foldViewToggleButton")
        NotificationCenter.default.post(name: NSNotification.Name(duringWorkoutVcVisibility), object: nil, userInfo: nil)
        guard let bottomWorkoutView = self.view else {return}
        
        if bottomWorkoutView.frame.height == foldedViewHeight {
            UIView.animate(withDuration: 0.01, animations: {
                bottomWorkoutView.frame = CGRect(x: 0, y: self.expandedViewHeight - (self.foldedViewHeight + 82), width: self.view.frame.width, height: self.foldedViewHeight + 200 )
                self.expandingAnimationQuick()
            }) { _ in
                UIView.animate(withDuration: 0.7) {
                    bottomWorkoutView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.expandedViewHeight)
                }
                self.expandingAnimationSlow()
//                self.workoutTimeLabel.superview?.layoutIfNeeded()
            }
        } else {
            self.foldingAnimationQuick()
            UIView.animate(withDuration: 0.01, animations: {
                bottomWorkoutView.frame =  CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.expandedViewHeight + 200)
                self.endWorkoutButton.superview?.layoutIfNeeded()
//                self.currentWorkoutLabel.superview?.layoutIfNeeded()

//                self.currentWorkoutLabel.frame = CGRect(x: 26, y: 100, width: 103, height: 20)
            }) {_ in
                UIView.animate(withDuration: 0.7) {
                    bottomWorkoutView.frame =  CGRect(x: 0, y: self.expandedViewHeight - (self.foldedViewHeight + 82), width: self.view.frame.width, height: self.foldedViewHeight)
                    
                    self.foldingAnimationSlow()
                    self.currentWorkoutLabel.superview?.layoutIfNeeded()
                }
            }
        }
        
    }

    @objc func endWorkoutButtonTapped() {
        print("dd")
    }
    
    //MARK: - Animations
    func foldingAnimationQuick() {
        foldViewToggleButton.setImage(UIImage(systemName: "chevron.up", withConfiguration: UIImage.SymbolConfiguration(pointSize: 41, weight: .bold)), for: .normal)
        
        workoutPlayView.layer.opacity = 0
    }
    func foldingAnimationSlow() {
        currentWorkoutLabel.frame = CGRect(x: 10, y: foldedViewHeight - 30, width: view.frame.width, height: view.frame.height)
    }
    func expandingAnimationQuick() {

        foldViewToggleButton.setImage(UIImage(systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 41, weight: .bold)), for: .normal)
//        foldViewToggleButton.frame = CGRect(x: 29, y: 100, width: 41, height: 41)
        

        endWorkoutButton.layer.opacity = 1
        foldedPlayButton.layer.opacity = 0
        workoutPlayView.layer.opacity = 1
        expandedPlayButton.layer.opacity = 1
        playButtonTitleLabel.layer.opacity = 1
        nextWorkoutButton.layer.opacity = 1
        nextWorkoutButtonTitleLabel.layer.opacity = 1
        previousWorkoutButton.layer.opacity = 1
        previousWorkoutButtonTitleLabel.layer.opacity = 1
        restButton.layer.opacity = 1
        restTimerUnderBarView.layer.opacity = 1
        restTimerLabel.layer.opacity = 1
        foldedworkoutTimeLabel.layer.opacity = 0
        restTimeLeftLabel.layer.opacity = 1
        currentWorkoutView.layer.opacity = 1
        currentWorkoutTitleLabel.layer.opacity = 1
        expandedTotalWorkoutTimeTitleLabel.layer.opacity = 1
        expandedTotalWorkoutTimeLabel.layer.opacity = 1

    }
    func expandingAnimationSlow() {
        endWorkoutButton.snp.remakeConstraints {
            $0.trailing.equalToSuperview().inset(14)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(30)
            $0.width.equalTo(80)
        }
        foldViewToggleButton.snp.remakeConstraints {
            $0.leading.equalToSuperview().inset(14)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(14)
            $0.height.width.equalTo(32)
        }
        
        
        currentWorkoutLabel.snp.remakeConstraints {
            $0.top.equalTo(currentWorkoutTitleLabel.snp.bottom).offset(9)
            $0.leading.equalToSuperview().inset(26)
        }


    }
}
// MARK: - EXTENSIONs
extension DuringWorkoutViewController {
    
}

