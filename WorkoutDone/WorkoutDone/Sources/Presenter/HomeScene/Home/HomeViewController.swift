//
//  HomeViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/03.
//

import UIKit

class HomeViewController : BaseViewController {
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
    
    private let calendarView = CalendarView()
    ///기록하기
    private let recordBaseView = RecordView().then {
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
        
        view.backgroundColor = .color7442FF
        contentScrollView.delegate = self
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func setupLayout() {
        super.setupLayout()
        navigationController?.isNavigationBarHidden = true
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentView)
        [calendarView, recordBaseView, workoutBaseView, workoutResultBaseView].forEach {
            contentView.addSubview($0)
        }
    }
    override func setComponents() {
        super.setComponents()
        view.backgroundColor = .colorFFFFFF
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
            $0.top.equalTo(calendarView.snp.bottom).offset(41)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(513)
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
    }
    override func actions() {
        super.actions()
        recordBaseView.workoutDoneCameraButton.addTarget(self, action: #selector(workoutDoneCameraButtonTapped), for: .touchUpInside)
        recordBaseView.bodyDataEntryButton.addTarget(self, action: #selector(bodyDataEntryButtonTapped), for: .touchUpInside)
        workoutBaseView.workoutRoutineChoiceButton.addTarget(self, action: #selector(workoutRoutineChoiceButtonTapped), for: .touchUpInside)
    }
    @objc func workoutDoneCameraButtonTapped() {
        let imageSelectionViewController = ImageSelectionViewController()
        imageSelectionViewController.rootView = self
        imageSelectionViewController.modalTransitionStyle = .crossDissolve
        imageSelectionViewController.modalPresentationStyle = .overFullScreen
        present(imageSelectionViewController, animated: true)
    }
    @objc func bodyDataEntryButtonTapped() {
        let registerMyBodyInfoViewController = RegisterMyBodyInfoViewController()
        registerMyBodyInfoViewController.modalTransitionStyle = .crossDissolve
        registerMyBodyInfoViewController.modalPresentationStyle = .overFullScreen
        present(registerMyBodyInfoViewController, animated: true)
    }
    @objc func workoutRoutineChoiceButtonTapped() {
        let workoutViewController = WorkoutViewController()
        navigationController?.pushViewController(workoutViewController, animated: true)
    }
 
}

extension HomeViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if UserDefaultsManager.shared.isMonthlyCalendar {
            if scrollView.contentOffset.y > CGFloat(monthlyCalendarHeight) {
                view.backgroundColor = .colorFFFFFF
            } else {
                view.backgroundColor = .color7442FF
            }
        } else {
            if scrollView.contentOffset.y > CGFloat(weeklyCalendarHeight) {
                view.backgroundColor = .colorFFFFFF
            } else {
                view.backgroundColor = .color7442FF
            }
        }
    }
}
