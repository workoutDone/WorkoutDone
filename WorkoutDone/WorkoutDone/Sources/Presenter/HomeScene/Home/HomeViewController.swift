//
//  HomeViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/03.
//

import UIKit
import Combine
import CoreDevice
import UIExtensions
import FoundationExtensions

class HomeViewController : BaseViewController, CalendarViewDelegate {
    
    
    //MARK: - ViewModel
    var homeViewModel = HomeViewModel()
    let frameImageViewModel = FrameImageViewModel()
    
    private var didLoad = PassthroughSubject<Void, Never>()
    var selectedDate = CurrentValueSubject<Int, Never>(Date().dateToInt())
    private lazy var input = HomeViewModel.Input(
        selectedDate: selectedDate.asDriver(),
        loadView: didLoad.asDriver())
    
    private lazy var output = homeViewModel.transform(input: input)
    
    
    // MARK: - PROPERTIES
    let monthlyCalendarHeight: Int = 289
    let weeklyCalendarHeight: Int = 115
    
    
    private let contentScrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
    }
    
    private let contentView = UIView().then {
        $0.backgroundColor = .colorFFFFFF
    }
    
    let calendarView = CalendarView()
    ///기록하기
    let recordBaseView = RecordView().then {
        $0.backgroundColor = .colorFFFFFF
    }
    ///운동하기
    private let workoutBaseView = WorkoutView().then {
        $0.backgroundColor = .colorFFFFFF
    }
    ///운동 결과
    private let workoutResultBaseView = WorkoutResultView().then {
        $0.backgroundColor = .colorFFFFFF
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentScrollView.delegate = self
        calendarView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        didLoad.send(())
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let dateInt = calendarView.selectDate?.dateToInt()
        print(dateInt ?? Date().dateToInt(), "dd")

    }

    override func setupLayout() {
        super.setupLayout()

        view.addSubviews(contentScrollView)
        contentScrollView.addSubview(contentView)
        [calendarView, recordBaseView, workoutBaseView, workoutResultBaseView].forEach {
            contentView.addSubview($0)
        }
    }
    override func setComponents() {
        super.setComponents()
        view.backgroundColor = .color7442FF
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.isUserInteractionEnabled = true
        contentScrollView.isScrollEnabled = true
        contentScrollView.isUserInteractionEnabled = true
    }
    override func setupConstraints() {
        super.setupConstraints()
        
        
        contentScrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        // 캘린더 view
        calendarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        ///기록하기 view
        recordBaseView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
        }
        ///운동하기 view
        workoutBaseView.snp.makeConstraints {
            $0.top.equalTo(recordBaseView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(146)
        }
        ///운동 결과
        workoutResultBaseView.snp.makeConstraints {
            $0.top.equalTo(workoutBaseView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(182)
            $0.bottom.equalToSuperview()
        }
        
    }
    override func setupBinding() {
        super.setupBinding()
        output.weightData.drive(onNext: { [weak self] value in
            self?.recordBaseView.weightInputLabel.text = value
        })
            .disposed(by: disposeBag)
        output.skeletalMusleMassData.drive(onNext: { [weak self] value in
            self?.recordBaseView.skeletalMuscleMassInputLabel.text = value
        })
            .disposed(by: disposeBag)
        output.fatPercentageData.drive(onNext: { [weak self] value in
            self?.recordBaseView.fatPercentageInputLabel.text = value
        })
            .disposed(by: disposeBag)
        output.imageData.drive(onNext: { [weak self] value in
            self?.recordBaseView.bodyImageView.image = value
        })
            .disposed(by: disposeBag)
        
        output.workoutTimeData.drive(onNext: { [weak self] value in
            self?.workoutResultBaseView.workoutTimeLabel.text = value
        })
            .disposed(by: disposeBag)
        
        output.workoutRoutineTitleData.drive(onNext: { [weak self] value in
            self?.workoutResultBaseView.workoutTypeLabel.text = value
        })
            .disposed(by: disposeBag)
        
        output.isWorkout.drive(onNext: { value in
            self.workoutBaseView.workoutCompleteBaseView.isHidden = !value
        })
        .disposed(by: disposeBag)
        
        
        output.routineBodyPartArray.drive(onNext: { [weak self] value in
            guard let self = self else { return }
            bodyPartCount(count: value.count)
            switch value.count {
            case 1:
                bindBodyPart(value[0])
            case 2:
                bindBodyPart(value[0], value[1])
            case 3...:
                bindBodyPart(value[0], value[1], value[2])
            default:
                print("")
            }
        })
        .disposed(by: disposeBag)

        
        selectedDate.send(Date().dateToInt())
    }
    
    override func actions() {
        super.actions()
        recordBaseView.workoutDoneCameraButton.addTarget(self, action: #selector(workoutDoneCameraButtonTapped), for: .touchUpInside)
        recordBaseView.bodyDataEntryButton.addTarget(self, action: #selector(bodyDataEntryButtonTapped), for: .touchUpInside)
        workoutBaseView.workoutRoutineChoiceButton.addTarget(self, action: #selector(workoutRoutineChoiceButtonTapped), for: .touchUpInside)
        workoutResultBaseView.workoutResultButton.addTarget(self, action: #selector(workoutResultButtonTapped), for: .touchUpInside)
    }
    @objc func workoutDoneCameraButtonTapped() {
        let imageSelectionViewController = ImageSelectionViewController(deviceProvider: DeviceKitAdapter())
        imageSelectionViewController.rootView = self
        imageSelectionViewController.modalTransitionStyle = .crossDissolve
        imageSelectionViewController.modalPresentationStyle = .overFullScreen
        imageSelectionViewController.selectedDate = calendarView.selectDate?.dateToInt()
        imageSelectionViewController.completionHandler = { [weak self] dateValue in
            guard let self else { return }
            self.selectedDate.send(dateValue)
        }
        present(imageSelectionViewController, animated: true)
    }
    @objc func bodyDataEntryButtonTapped() {
        let registerMyBodyInfoViewController = RegisterMyBodyInfoViewController()
        registerMyBodyInfoViewController.selectedDate = calendarView.selectDate?.dateToInt()
        registerMyBodyInfoViewController.modalTransitionStyle = .crossDissolve
        registerMyBodyInfoViewController.modalPresentationStyle = .overFullScreen
        present(registerMyBodyInfoViewController, animated: true)
        registerMyBodyInfoViewController.completionHandler = { [weak self] dateValue in
            guard let self else { return }
            self.selectedDate.send(dateValue)
        } 
    }
    @objc func workoutRoutineChoiceButtonTapped() {
        let workoutViewController = WorkoutViewController()
        workoutViewController.completionHandler = {
            let duringWorkoutViewController = DuringWorkoutViewController(deviceProvider: DeviceKitAdapter())
            let navigationController = UINavigationController(rootViewController: duringWorkoutViewController)
            navigationController.modalTransitionStyle = .crossDissolve
            navigationController.modalPresentationStyle = .fullScreen
            UserDefaultsManager.shared.save(value: true, forkey: .isWorkout)
            self.present(navigationController, animated: true)
        }
        workoutViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(workoutViewController, animated: true)
    }
    @objc func workoutResultButtonTapped() {
        let workoutResultViewController = WorkoutResultViewController()
        let dateValue = calendarView.selectDate ?? Date()
        let dateId = dateValue.dateToInt()
        workoutResultViewController.selectedDate = dateId
        workoutResultViewController.completionHandler = { [weak self] dateValue in
            self?.selectedDate.send(dateValue)
        }
        navigationController?.pushViewController(workoutResultViewController, animated: true)
    }

    func didSelectedCalendarDate() {
        guard let dateInt = calendarView.selectDate?.dateToInt() else { return }
        selectedDate.send(dateInt)
    }
    
    private func bindBodyPart(_ firstBodyPart: String, _ secondBodyPart: String? = nil, _ thirdBodyPart: String? = nil) {
        workoutResultBaseView.workoutTypeFirstLabel.text = firstBodyPart
        workoutResultBaseView.workoutTypeSecondLabel.text = secondBodyPart
        workoutResultBaseView.workoutTypeThirdLabel.text = thirdBodyPart
    }
    private func bodyPartCount(count: Int) {
        switch count {
        case 0:
            workoutResultBaseView.workoutTypeFirstView.isHidden = true
            workoutResultBaseView.workoutTypeSecondView.isHidden = true
            workoutResultBaseView.workoutTypeThirdView.isHidden = true
            workoutResultBaseView.workoutTypeLabel.isHidden = false
        case 1:
            workoutResultBaseView.workoutTypeFirstView.isHidden = false
            workoutResultBaseView.workoutTypeSecondView.isHidden = true
            workoutResultBaseView.workoutTypeThirdView.isHidden = true
            workoutResultBaseView.workoutTypeLabel.isHidden = true
        case 2:
            workoutResultBaseView.workoutTypeFirstView.isHidden = false
            workoutResultBaseView.workoutTypeSecondView.isHidden = false
            workoutResultBaseView.workoutTypeThirdView.isHidden = true
            workoutResultBaseView.workoutTypeLabel.isHidden = true
        case 3...:
            workoutResultBaseView.workoutTypeFirstView.isHidden = false
            workoutResultBaseView.workoutTypeSecondView.isHidden = false
            workoutResultBaseView.workoutTypeThirdView.isHidden = false
            workoutResultBaseView.workoutTypeLabel.isHidden = true
        default:
            print("예외")
        }
    }
}

extension HomeViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if UserDefaultsManager.shared.isMonthlyCalendar {
            if scrollView.contentOffset.y > CGFloat(monthlyCalendarHeight) {
                view.backgroundColor = .colorFFFFFF
            } else {
                view.backgroundColor = .colorF6F4FF
            }
        } else {
            if scrollView.contentOffset.y > CGFloat(weeklyCalendarHeight) {
                view.backgroundColor = .colorFFFFFF
            } else {
                view.backgroundColor = .colorF6F4FF
            }
        }
    }
}
