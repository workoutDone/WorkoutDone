//
//  DuringWorkoutResultViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/06/13.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

final class DuringWorkoutResultViewController : BaseViewController {
    
    private var routineData : Routine?
    
    private let didLoad = PublishSubject<Void>()
    private let homeButtonTrigger = PublishSubject<Void>()
    
    private let viewModel = DuringWorkoutResultViewModel()
    private lazy var input = DuringWorkoutResultViewModel.Input(
        loadView: didLoad.asDriver(onErrorJustReturn: ()),
        homeButtonTrigger: homeButtonTrigger.asDriver(onErrorJustReturn: ()))
    private lazy var output = viewModel.transform(input: input)
    
    // MARK: - PROPERTIES
    private let routineLabel = UILabel().then {
        $0.text = "루틴"
        $0.textColor = .color7442FF
        $0.font = .pretendard(.semiBold, size: 18)
        $0.backgroundColor = .colorE6E0FF
        $0.layer.cornerRadius = 13
        $0.clipsToBounds = true
        $0.textAlignment = .center
    }
    
    private let myRoutineLabel = UILabel().then {
        $0.text = "등을 조져보자"
        $0.textColor = .color121212
        $0.font = .pretendard(.semiBold, size: 22)
    }
    private lazy var routineStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [routineLabel, myRoutineLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let totalWorkoutTimeBackView = UIView().then {
        $0.backgroundColor = .colorF8F6FF
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }
    private let totalWorkoutTimeLabel = UILabel().then {
        $0.text = "총 운동 시간"
        $0.textColor = .color5E5E5E
        $0.font = .pretendard(.semiBold, size: 16)
    }
    
    private let myTotalWorkoutTimeLabel = UILabel().then {
        $0.text = "30:33"
        $0.textColor = .color7442FF
        $0.font = .pretendard(.semiBold, size: 16)
    }
    
    private let workoutTableView = UITableView().then {
        $0.backgroundColor = .colorE6E0FF
        $0.layer.cornerRadius = 16
        $0.separatorStyle = .none
    }
    
    private let homeButton = GradientButton(colors: [UIColor.color8E36FF.cgColor, UIColor.color7442FF.cgColor]).then {
        $0.setTitle("홈으로 돌아가기", for: .normal)
        $0.titleLabel?.font = .pretendard(.bold, size: 20)
    }
    
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupBinding() {
        super.setupBinding()

        output.routineData.drive(onNext: { value in
            self.routineData = value
            self.workoutTableView.reloadData()
        })
        .disposed(by: disposeBag)
        
        output.routineTitle.drive(myRoutineLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.workoutTimeData.drive(myTotalWorkoutTimeLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.deleteTemporaryRoutine.drive(onNext: { value in
            if value {
                let tabBarController = TabBarController()
                tabBarController.modalTransitionStyle = .crossDissolve
                tabBarController.modalPresentationStyle = .fullScreen
                UserDefaultsManager.shared.remove(.isWorkout)
                self.present(tabBarController, animated: true)
            }
        })
        .disposed(by: disposeBag)
        
        homeButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                self.homeButtonTrigger.onNext(())
            }
            .disposed(by: disposeBag)
        
        didLoad.onNext(())
    }
    
    override func setComponents() {
        super.setComponents()
        navigationItem.title = "운동 결과"
        view.backgroundColor = .colorFFFFFF
        
        workoutTableView.delegate = self
        workoutTableView.dataSource = self
        workoutTableView.register(DuringWorkoutResultSectionCell.self, forCellReuseIdentifier: DuringWorkoutResultSectionCell.identifier)
        workoutTableView.rowHeight = UITableView.automaticDimension
        workoutTableView.estimatedRowHeight = 50
    }
    override func setupLayout() {
        super.setupLayout()
        view.addSubviews(routineStackView, totalWorkoutTimeBackView, homeButton, workoutTableView)
        totalWorkoutTimeBackView.addSubviews(totalWorkoutTimeLabel, myTotalWorkoutTimeLabel)
        
    }
    override func setupConstraints() {
        super.setupConstraints()
        
        workoutTableView.snp.makeConstraints {
            $0.top.equalTo(totalWorkoutTimeBackView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalTo(homeButton.snp.top).offset(-43)
        }
        homeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(58)
            $0.leading.equalTo(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-21)
        }
        routineStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(21)
            $0.centerX.equalToSuperview()
        }
        routineLabel.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.width.equalTo(54)
        }
        totalWorkoutTimeBackView.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.width.equalTo(200)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(routineStackView.snp.bottom).offset(12)
        }
        totalWorkoutTimeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(6)
        }
        myTotalWorkoutTimeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    // MARK: - ACTIONS
}

// MARK: - EXTENSIONS
extension DuringWorkoutResultViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routineData?.weightTraining.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DuringWorkoutResultSectionCell.identifier, for: indexPath) as? DuringWorkoutResultSectionCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.workoutSectionTableView.snp.updateConstraints {
            $0.height.equalTo(49 * (cell.weightTrainingValue?.weightTrainingInfo.count ?? 1))
            $0.top.equalTo(cell.workoutTitle.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(11)
        }
        cell.configureCell(routineData?.weightTraining[indexPath.row] ?? WeightTraining(bodyPart: "", weightTraining: ""))
        cell.weightTrainingValue = routineData?.weightTraining[indexPath.row] ?? WeightTraining(bodyPart: "", weightTraining: "")
        cell.completionHandler = { [weak self] value in
            if value {
                self?.workoutTableView.reloadData()
                print("자꾸 호출?")
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    
}
