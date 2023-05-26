//
//  DuringWorkoutViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/19.
//

import UIKit

class DuringWorkoutViewController : BaseViewController {
    private var timer : Timer = Timer()
    private var count : Int = 0
    private var timerCounting : Bool = false

    // MARK: - PROPERTIES
    private let endWorkoutButton = RightBarButtonItem(title: "운동 종료", buttonBackgroundColor: .colorFFEDF0, titleColor: .colorF54968).then {
        $0.layer.cornerRadius = 5
    }
    private let currentWorkoutView = UIView()
    private let currentWorkoutTitleLabel = UILabel().then {
        $0.text = "현재 운동"
        $0.font = .pretendard(.regular, size: 14)
        $0.textColor = .color7442FF
    }
    private let currentWorkoutLabel = UILabel().then {
        $0.font = .pretendard(.bold, size: 24)
        $0.text = "뎀벨프레스"
        $0.textColor = .color121212
    }
        private let totalWorkoutTimeTitleLabel = UILabel().then {
            $0.text = "총 운동 시간"
            $0.textColor = .color121212
            $0.font = .pretendard(.regular, size: 12)
        }
    
        private let totalWorkoutTimeLabel = UILabel().then {
            $0.text = "00:08:00"
            $0.textColor = .color121212
            $0.font = .pretendard(.semiBold, size: 20)
        }
    private let progressBackView = UIView().then {
        $0.backgroundColor = .colorE2E2E2
    }
    private let progressView = UIView().then {
        $0.backgroundColor = .color363636
    }
    private let workoutPlayView = UIView().then {
        $0.backgroundColor = .colorF8F6FF
        $0.layer.cornerRadius = 42
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.colorE6E0FF.cgColor
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    private let restButton = UIButton().then {
        $0.setTitle("휴식하기", for: .normal)
        $0.setTitleColor(UIColor.colorFFFFFF, for: .normal)
        $0.backgroundColor = .colorF54968
        $0.layer.cornerRadius = 12
        $0.titleLabel?.font = .pretendard(.bold, size: 16)
    }
    private let restBackView = UIView()
    
    private let restTimeLeftLabel = UILabel().then {
        $0.text = "남은 휴식시간"
        $0.font = .pretendard(.regular, size: 14)
        $0.textColor = .colorF54968
    }
    private let restTimerLabel = UILabel().then {
        $0.text = "01:29"
        $0.font = .pretendard(.semiBold, size: 32)
        $0.textColor = .colorF54968
    }
    private let restTimerUnderBarView = UIView().then {
        $0.backgroundColor = .colorF54968
    }
    
    private lazy var restStackView : UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [restBackView, restButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 30
        stackView.alignment = .bottom
        return stackView
    }()
    private let playButton = UIButton().then {
        $0.setImage(UIImage(named: "playImage"), for: .normal)
    }
    private let playButtonTitleLabel = UILabel().then {
        $0.text = "운동 재개"
        $0.font = .pretendard(.semiBold, size: 14)
        $0.textColor = .color7442FF
    }

    private let nextWorkoutButton = UIButton().then {
        $0.setImage(UIImage(named: "nextWorkoutButton"), for: .normal)
    }

    private let nextWorkoutButtonTitleLabel = UILabel().then {
        $0.text = "다음 운동"
        $0.font = .pretendard(.regular, size: 14)
        $0.textColor = .color7442FF
    }

    private let previousWorkoutButton = UIButton().then {
        $0.setImage(UIImage(named: "previousWorkoutButton"), for: .normal)
    }

    private let previousWorkoutButtonTitleLabel = UILabel().then {
        $0.text = "이전 운동"
        $0.font = .pretendard(.regular, size: 14)
        $0.textColor = .color7442FF
    }
    
    private lazy var duringSetViewController = DuringSetViewController()
    private lazy var duringEditRoutineViewController = DuringEditRoutineViewController()
    
    private lazy var viewControllers : [UIViewController] = {
        return [duringSetViewController, duringEditRoutineViewController]
    }()
    private lazy var pageViewController : UIPageViewController = {
        let viewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        return viewController
    }()

    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        timerCounting = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
    }
    override func setupBinding() {
        
    }
    override func setComponents() {
        super.setComponents()
        view.backgroundColor = .colorFFFFFF
        let barButton = UIBarButtonItem()
        barButton.customView = endWorkoutButton
        navigationItem.rightBarButtonItem = barButton
        
        pageViewController.didMove(toParent: self)
        pageViewController.view.frame = self.view.frame
        pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: true)
    }
    
    
    override func setupLayout() {
        self.addChild(pageViewController)
        view.addSubviews(currentWorkoutView, workoutPlayView,restStackView, pageViewController.view)
        workoutPlayView.addSubviews(playButton, playButtonTitleLabel, nextWorkoutButton, nextWorkoutButtonTitleLabel, previousWorkoutButtonTitleLabel, previousWorkoutButton)
        currentWorkoutView.addSubviews(currentWorkoutTitleLabel, currentWorkoutLabel, totalWorkoutTimeTitleLabel, totalWorkoutTimeLabel, progressBackView, progressView)
        restBackView.addSubviews(restTimeLeftLabel, restTimerLabel, restTimerUnderBarView)
    }
    override func setupConstraints() {
        endWorkoutButton.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(80)
        }
        currentWorkoutView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(71)
        }
        currentWorkoutTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(26)
            $0.top.equalToSuperview().inset(12)
        }
        currentWorkoutLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(26)
            $0.bottom.equalToSuperview().inset(10)
        }
        totalWorkoutTimeTitleLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(26)
            $0.top.equalToSuperview().inset(23)
        }
        totalWorkoutTimeLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(26)
        }
        progressBackView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        progressView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width / 2)
            $0.height.equalTo(1.5)
        }
        if DeviceManager.shared.isHomeButtonDevice() || DeviceManager.shared.isSimulatorIsHomeButtonDevice() {
            workoutPlayView.snp.makeConstraints {
                $0.height.equalTo(130 - 34)
                $0.bottom.equalToSuperview()
                $0.leading.trailing.equalToSuperview()
            }
            restStackView.snp.makeConstraints {
                $0.bottom.equalTo(workoutPlayView.snp.top).offset(-23)
                $0.centerX.equalToSuperview()
            }
        }
        else {
            workoutPlayView.snp.makeConstraints {
                $0.height.equalTo(130)
                $0.bottom.equalToSuperview()
                $0.leading.trailing.equalToSuperview()
            }
            restStackView.snp.makeConstraints {
                $0.bottom.equalTo(workoutPlayView.snp.top).offset(-33)
                $0.centerX.equalToSuperview()
            }
        }
        restBackView.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.width.equalTo(113)
        }
        restTimeLeftLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(5)
        }
        restTimerLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(restTimerUnderBarView.snp.top).offset(4)
            
        }
        restTimerUnderBarView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(92)
            $0.height.equalTo(1)
        }
        restButton.snp.makeConstraints {
            $0.width.equalTo(148)
            $0.height.equalTo(45)
        }
        playButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(46)
        }
        playButtonTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(playButton.snp.bottom).offset(7)
        }
        nextWorkoutButton.snp.makeConstraints {
            $0.centerY.equalTo(playButton.snp.centerY)
            $0.trailing.equalToSuperview().inset(83)
            $0.height.equalTo(14.16)
            $0.width.equalTo(25.01)
        }
        nextWorkoutButtonTitleLabel.snp.makeConstraints {
            $0.centerX.equalTo(nextWorkoutButton.snp.centerX)
            $0.top.equalTo(nextWorkoutButton.snp.bottom).offset(7)
        }
        previousWorkoutButton.snp.makeConstraints {
            $0.centerY.equalTo(playButton.snp.centerY)
            $0.leading.equalToSuperview().inset(83)
            $0.height.equalTo(14.16)
            $0.width.equalTo(25.01)
        }
        previousWorkoutButtonTitleLabel.snp.makeConstraints {
            $0.centerX.equalTo(previousWorkoutButton.snp.centerX)
            $0.top.equalTo(previousWorkoutButton.snp.bottom).offset(7)
        }
        
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(currentWorkoutView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(restBackView.snp.top)
        }
    }
    

    
    // MARK: - ACTIONS
    override func actions() {
        super.actions()
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeLeftGesture.direction = .left
        swipeRightGesture.direction = .right
        view.addGestureRecognizer(swipeLeftGesture)
        view.addGestureRecognizer(swipeRightGesture)
        
        restButton.addTarget(self, action: #selector(restButtonTapped), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    }
    
    @objc func playButtonTapped() {
        if timerCounting {
            timerCounting = false
            timer.invalidate()
            //토글 해주기 todo
        }
        else {
            timerCounting = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            //토글 해주기 todo
        }
    }
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        totalWorkoutTimeLabel.text = timeString
    }
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    @objc func restButtonTapped() {
        let duringWorkoutTimerViewController = DuringWorkoutTimerViewController()
        duringWorkoutTimerViewController.modalTransitionStyle = .crossDissolve
        duringWorkoutTimerViewController.modalPresentationStyle = .overFullScreen
        present(duringWorkoutTimerViewController, animated: true)
    }
    
    @objc func swipeAction(_ sender : UISwipeGestureRecognizer) {
        if sender.direction == .right {
            pageViewController.setViewControllers([viewControllers[0]], direction: .reverse, animated: true)
        }
        else if sender.direction == .left {
            pageViewController.setViewControllers([viewControllers[1]], direction: .forward, animated: true)
        }
    }
}
// MARK: - EXTENSIONs
extension DuringWorkoutViewController {
    
}

