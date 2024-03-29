//
//  TodayWorkoutResultView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/06/13.
//

import UIKit
import Then
import SnapKit

final class TodayWorkoutResultView : BaseUIView {
    
    var routineData : Routine?
    
    let routineLabel = UILabel().then {
        $0.text = "루틴"
        $0.textColor = .color7442FF
        $0.font = .pretendard(.semiBold, size: 18)
        $0.backgroundColor = .colorE6E0FF
        $0.layer.cornerRadius = 13
        $0.clipsToBounds = true
        $0.textAlignment = .center
    }
    
    let myRoutineLabel = UILabel().then {
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
    
    let myTotalWorkoutTimeLabel = UILabel().then {
        $0.text = "00:00"
        $0.textColor = .color7442FF
        $0.font = .pretendard(.semiBold, size: 16)
    }
    
    let workoutTableView = UITableView().then {
        $0.backgroundColor = .colorE6E0FF
        $0.layer.cornerRadius = 16
        $0.separatorStyle = .none
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDelegateDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupLayout() {
        super.setupLayout()
        self.addSubviews(routineStackView, totalWorkoutTimeBackView, workoutTableView)
        totalWorkoutTimeBackView.addSubviews(totalWorkoutTimeLabel, myTotalWorkoutTimeLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        routineStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
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
        workoutTableView.snp.makeConstraints {
            $0.top.equalTo(totalWorkoutTimeBackView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(30)
        }
    }
    private func setDelegateDataSource() {
        workoutTableView.delegate = self
        workoutTableView.dataSource = self
        workoutTableView.register(DuringWorkoutResultSectionCell.self, forCellReuseIdentifier: DuringWorkoutResultSectionCell.identifier)
        workoutTableView.rowHeight = UITableView.automaticDimension
        workoutTableView.estimatedRowHeight = 50
    }
    
}

extension TodayWorkoutResultView : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routineData?.weightTraining.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DuringWorkoutResultSectionCell.identifier, for: indexPath) as? DuringWorkoutResultSectionCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.weightTrainingValue = routineData?.weightTraining[indexPath.row] ?? WeightTraining(bodyPart: "", weightTraining: "")
        cell.configureCell(routineData?.weightTraining[indexPath.row] ?? WeightTraining(bodyPart: "", weightTraining: ""))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
