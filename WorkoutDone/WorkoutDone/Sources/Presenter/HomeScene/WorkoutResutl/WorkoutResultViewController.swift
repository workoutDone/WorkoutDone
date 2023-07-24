//
//  WorkoutResultViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/13.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa


class WorkoutResultViewController : BaseViewController {
    var selectedDate : Int?
    
    
    var completionHandler : ((Int) -> Void)?
    // MARK: - ViewModel
    private var viewModel = WorkoutResultViewModel()
    private var loadView = PublishSubject<Void>()
    
    private lazy var input = WorkoutResultViewModel.Input(
        loadView: loadView.asDriver(onErrorJustReturn: ()),
        selectedData: Driver.just(selectedDate!).asDriver(onErrorJustReturn: 0))
    private lazy var output = viewModel.transform(input: input)
    
    // MARK: - PROPERTIES
    private let deleteRecordButton = UIButton().then {
        $0.setTitle("기록 삭제", for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(.semiBold, size: 16)
        $0.setTitleColor(UIColor.colorF54968, for: .normal)
        $0.backgroundColor = UIColor.colorFFEDF0
        $0.layer.cornerRadius = 5
    }
    
    private let todayEmptyWorkoutResultView = TodayEmptyWorkoutResultView().then {
        $0.isHidden = true
    }
    
    
    private let todayWorkoutResultView = TodayWorkoutResultView().then {
        $0.isHidden = true
    }
    
    // MARK: - LIFECYCLE
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
            hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setupBinding() {
        super.setupBinding()
        
        output.hasData.drive(onNext: { value in
            if value {
                DispatchQueue.main.async {
                    self.todayEmptyWorkoutResultView.isHidden = true
                    self.todayWorkoutResultView.isHidden = false
                }
            }
            else {
                DispatchQueue.main.async {
                    self.todayEmptyWorkoutResultView.isHidden = false
                    self.todayWorkoutResultView.isHidden = true
                    self.deleteRecordButton.isHidden = true
                }
            }
        })
        .disposed(by: disposeBag)
        
        output.routineData.drive(onNext: { value in
            self.todayWorkoutResultView.routineData = value
            self.todayWorkoutResultView.workoutTableView.reloadData()
        })
        .disposed(by: disposeBag)
        
        output.routineTitleData.drive(todayWorkoutResultView.myRoutineLabel.rx.text)
            .disposed(by: disposeBag)
        

        output.hasRoutineTitle.drive(onNext: { [weak self] value in
            guard let self = self else { return }
            print(value, "타이틀??")
            if value {
                self.todayWorkoutResultView.myRoutineLabel.isHidden = false
                self.todayWorkoutResultView.routineLabel.isHidden = false
            }
            else {
            self.todayWorkoutResultView.myRoutineLabel.isHidden = true
            self.todayWorkoutResultView.routineLabel.isHidden = true
            }
        })
        .disposed(by: disposeBag)
        
        output.workoutTimeData.drive(todayWorkoutResultView.myTotalWorkoutTimeLabel.rx.text)
            .disposed(by: disposeBag)
        
        loadView.onNext(())
    }
    override func setComponents() {
        view.backgroundColor = .colorFFFFFF
        navigationItem.title = "운동 기록"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.color121212]
        navigationController?.isNavigationBarHidden = false
        let barButton = UIBarButtonItem()
        barButton.customView = deleteRecordButton
        navigationItem.rightBarButtonItem = barButton
        
    }
    override func setupLayout() {
        view.addSubviews(todayWorkoutResultView, todayEmptyWorkoutResultView)
    }
    override func setupConstraints() {
        deleteRecordButton.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(80)
        }
        todayWorkoutResultView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        todayEmptyWorkoutResultView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func actions() {
        deleteRecordButton.addTarget(self, action: #selector(deleteRecordButtonTapped), for: .touchUpInside)
    }
    @objc func deleteRecordButtonTapped() {
        let deleteRecordAlertViewController = DeleteRecordAlertViewController()
        deleteRecordAlertViewController.modalTransitionStyle = .crossDissolve
        deleteRecordAlertViewController.modalPresentationStyle = .overFullScreen
        deleteRecordAlertViewController.selectedDate = selectedDate
        deleteRecordAlertViewController.completionHandler = {
            [weak self] dateValue in
            guard let self else { return }
            self.completionHandler?(dateValue)
            self.navigationController?.popViewController(animated: false)
        }
        present(deleteRecordAlertViewController, animated: true)
    }
    
    // MARK: - ACTIONS
}
// MARK: - EXTENSIONs
extension WorkoutResultViewController {
    
}

