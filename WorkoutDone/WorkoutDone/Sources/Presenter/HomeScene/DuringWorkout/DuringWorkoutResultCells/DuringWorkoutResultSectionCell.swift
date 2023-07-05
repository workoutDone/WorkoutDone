//
//  DuringWorkoutResultSectionCell.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/07/03.
//

import UIKit

final class DuringWorkoutResultSectionCell : UITableViewCell {
    static let identifier = "DuringSetTableViewCell"
    var completionHandler : ((Bool) -> Void)?
    
    var weightTrainingValue : WeightTraining?
    var index: IndexPath?
    
    private let backView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color7442FF.cgColor
        $0.backgroundColor = .colorFFFFFF
    }
    
    private let workoutTitle = UILabel().then {
        $0.font = .pretendard(.semiBold, size: 20)
        $0.textColor = .color121212
        $0.backgroundColor = .red
    }
    private let workoutSectionTableView = UITableView().then {
        $0.backgroundColor = .colorFFFFFF
        $0.separatorStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        workoutSectionTableView.snp.updateConstraints {
//            $0.height.equalTo((weightTrainingValue?.weightTrainingInfo.count ?? 0) * 49)
//        }
//        print((weightTrainingValue?.weightTrainingInfo.count ?? 0), "으아아아아ㅏ")
//        workoutSectionTableView.snp.remakeConstraints {
//            $0.height.equalTo(49 * (weightTrainingValue?.weightTrainingInfo.count ?? 0))
//            $0.top.equalTo(workoutTitle.snp.bottom).offset(10)
//            $0.bottom.equalToSuperview().inset(20)
//            $0.leading.trailing.equalToSuperview().inset(11)
//        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStyle()
        setLayout()
        setComponents()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func setComponents() {
        workoutSectionTableView.delegate = self
        workoutSectionTableView.dataSource = self
        workoutSectionTableView.register(DuringWorkoutResultSetCell.self, forCellReuseIdentifier: DuringWorkoutResultSetCell.identifier)
        workoutSectionTableView.isScrollEnabled = false
//        workoutSectionTableView.rowHeight = UITableView.automaticDimension
//        workoutSectionTableView.rowHeight = 300
    }

    private func setStyle() {
        contentView.backgroundColor = .colorE6E0FF
    }
    private func setLayout() {
        print(weightTrainingValue, "얍")
        print("뭐가 먼저일까")
        contentView.addSubview(backView)
        backView.addSubviews(workoutTitle, workoutSectionTableView)
        
        backView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.trailing.equalToSuperview().inset(14)
        }
        workoutTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(21)
        }
        workoutSectionTableView.snp.makeConstraints {
//            $0.height.equalTo(49)
            $0.height.equalTo(49 * (weightTrainingValue?.weightTrainingInfo.count ?? 1))
            $0.top.equalTo(workoutTitle.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(11)
        }
    }
    func configureCell(_ weightTraining : WeightTraining) {
        workoutTitle.text = weightTraining.weightTraining
        
//        workoutSectionTableView.snp.remakeConstraints {
//            $0.height.equalTo(49 * (weightTrainingValue?.weightTrainingInfo.count ?? 1))
//            $0.top.equalTo(workoutTitle.snp.bottom).offset(10)
//            $0.bottom.equalToSuperview().inset(20)
//            $0.leading.trailing.equalToSuperview().inset(11)
//        }
//        completionHandler?(true)
    }
}
extension DuringWorkoutResultSectionCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weightTrainingValue?.weightTrainingInfo.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DuringWorkoutResultSetCell.identifier, for: indexPath) as? DuringWorkoutResultSetCell else { return UITableViewCell() }
        cell.configureCell(weightTrainingValue?.weightTrainingInfo[indexPath.row] ?? WeightTrainingInfo(setCount: 0, trainingCount: 0))
//        workoutSectionTableView.snp.remakeConstraints {
//            $0.height.equalTo(49 * (weightTrainingValue?.weightTrainingInfo.count ?? 1))
//            $0.top.equalTo(workoutTitle.snp.bottom).offset(10)
//            $0.bottom.equalToSuperview().inset(20)
//            $0.leading.trailing.equalToSuperview().inset(11)
//        }
        completionHandler?(true)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49
    }
    
}
