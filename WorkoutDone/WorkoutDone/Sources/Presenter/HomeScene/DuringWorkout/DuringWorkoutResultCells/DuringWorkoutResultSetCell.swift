//
//  DuringWorkoutResultSetCell.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/07/03.
//

import UIKit

final class DuringWorkoutResultSetCell : UITableViewCell {
    static let identifier = "DuringWorkoutResultSetCell"
    
    private let backView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.colorE6E0FF.cgColor
        $0.backgroundColor = .colorFFFFFF
    }
    private let setLabel = UILabel()
    
    private let weightLabel = UILabel()
    
    private let countLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
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

    }
    
    private func setStyle() {
        contentView.backgroundColor = .colorFFFFFF
    }
    private func setLayout() {
        contentView.addSubview(backView)
        backView.addSubviews(setLabel, weightLabel, countLabel)
        
        backView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview()
        }
        setLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        countLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        weightLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
    }
    func configureCell(_ weightTrainingInfo : WeightTrainingInfo) {
//        weightLabel.text = String(weightTrainingInfo.weight)
        setLabel.text = String(weightTrainingInfo.setCount) + "세트"
        countLabel.text = String(weightTrainingInfo.trainingCount ?? 0) + "개"
    }
    
}
