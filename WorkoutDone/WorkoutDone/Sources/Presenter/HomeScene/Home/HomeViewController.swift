//
//  HomeViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/03.
//

import UIKit

class HomeViewController : BaseViewController {
    // MARK: - PROPERTIES
    private let contentScrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
    }
    private let contentView = UIView()
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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func setupLayout() {
        super.setupLayout()
        navigationController?.isNavigationBarHidden = true
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentView)
        [recordBaseView, workoutBaseView, workoutResultBaseView].forEach {
            contentView.addSubview($0)
        }
    }
    override func setupConstraints() {
        super.setupConstraints()
        view.backgroundColor = .colorFFFFFF
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.isUserInteractionEnabled = true
        contentScrollView.isScrollEnabled = true
        contentScrollView.isUserInteractionEnabled = true
        
        contentScrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        // Todo - 캘린더 추가해야함
        ///기록하기 view
        recordBaseView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
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
