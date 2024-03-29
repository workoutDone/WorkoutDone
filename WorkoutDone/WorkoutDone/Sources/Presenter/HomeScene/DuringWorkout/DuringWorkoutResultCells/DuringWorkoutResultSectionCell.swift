//
//  DuringWorkoutResultSectionCell.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/07/03.
//

import UIKit

final class DuringWorkoutResultSectionCell : UITableViewCell {
    static let identifier = "DuringSetTableViewCell"
    var weightTrainingValue : WeightTraining?
    
    
    private let backView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color7442FF.cgColor
        $0.backgroundColor = .colorFFFFFF
    }
    
    private let workoutTitle = UILabel().then {
        $0.font = .pretendard(.semiBold, size: 20)
        $0.textColor = .color121212
    }
    private let workoutSectionTableView = UITableView().then {
        $0.backgroundColor = .colorFFFFFF
        $0.separatorStyle = .none
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
        setStyle()
        setLayout()
        setComponents()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        workoutTitle.text = nil    }
    private func setComponents() {
        workoutSectionTableView.delegate = self
        workoutSectionTableView.dataSource = self
        workoutSectionTableView.register(DuringWorkoutResultSetCell.self, forCellReuseIdentifier: DuringWorkoutResultSetCell.identifier)
        workoutSectionTableView.isScrollEnabled = false
    }

    private func setStyle() {
        contentView.backgroundColor = .colorE6E0FF
    }
    private func setLayout() {
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
            $0.height.equalTo(49)
            $0.top.equalTo(workoutTitle.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(11)
        }

    }
    func configureCell(_ weightTraining : WeightTraining) {
        workoutTitle.text = weightTraining.weightTraining
        weightTrainingValue = weightTraining
        
        workoutSectionTableView.snp.remakeConstraints {
            $0.height.equalTo(49 * weightTraining.weightTrainingInfo.count)
            $0.top.equalTo(workoutTitle.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(11)
        }

    }

}
extension DuringWorkoutResultSectionCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weightTrainingValue?.weightTrainingInfo.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DuringWorkoutResultSetCell.identifier, for: indexPath) as? DuringWorkoutResultSetCell else { return UITableViewCell() }
        if let weightTrainingValue = weightTrainingValue {
            cell.configureCell(weightTrainingValue.weightTrainingInfo[indexPath.row])
            cell.checkCalisthenics(weightTrainingValue)
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49
    }

}
