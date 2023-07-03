//
//  DuringWorkoutResultSectionCell.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/07/03.
//

import UIKit

final class DuringWorkoutResultSectionCell : UITableViewCell {
    static let identifier = "DuringSetTableViewCell"
    
    private let backView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color7442FF.cgColor
        $0.backgroundColor = .colorFFFFFF
    }
    
    private let workoutTitle = UILabel().then {
        $0.text = "턱걸이"
        $0.font = .pretendard(.semiBold, size: 20)
        $0.textColor = .color121212
    }
    private let workoutSectionTableView = UITableView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStyle()
        setLayout()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setStyle() {
        contentView.backgroundColor = .colorE6E0FF
    }
    func setLayout() {
        contentView.addSubview(backView)
        backView.addSubviews(workoutTitle)
        
        backView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.trailing.equalToSuperview().inset(14)
        }
        workoutTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(21)
            $0.bottom.equalToSuperview().inset(21)
        }
    }
    func configureCell(_ weightTraining : WeightTraining) {
        workoutTitle.text = weightTraining.weightTraining
    }
}
