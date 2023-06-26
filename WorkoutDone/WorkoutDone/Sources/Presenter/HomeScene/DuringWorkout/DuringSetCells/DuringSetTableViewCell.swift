//
//  DuringSetTableViewCell.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/29.
//

import UIKit

class DuringSetTableViewCell : UITableViewCell {
    static let identifier = "DuringSetTableViewCell"
    
    private let backView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .colorFFFFFF
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color7442FF.cgColor
    }
    
    private let setLabel = UILabel().then {
        $0.text = "1세트"
        $0.font = .pretendard(.medium, size: 16)
        $0.textColor = .color7442FF
    }
    
    private let kgLabel = UILabel().then {
        $0.text = "-kg"
        $0.font = .pretendard(.medium, size: 16)
        $0.textColor = .color7442FF
    }
    
    private let countLabel = UILabel().then {
        $0.text = "-회"
        $0.font = .pretendard(.medium, size: 16)
        $0.textColor = .color7442FF
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 7, left: 0, bottom: 7, right: 0))
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
        
    }
    func setLayout() {
        contentView.addSubview(backView)
        backView.addSubviews(setLabel, kgLabel, countLabel)
        backView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        setLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        kgLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        countLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    func configureCell(_ wegihtTrainingInfo : WeightTrainingInfo) {
        setLabel.text = "\(wegihtTrainingInfo.setCount)세트"
        kgLabel.text = wegihtTrainingInfo.weight == 0 ? "-kg" : "\(wegihtTrainingInfo.weight ?? 0)kg"
        countLabel.text = wegihtTrainingInfo.trainingCount == 0 ? "-회" : "\(wegihtTrainingInfo.trainingCount ?? 0)회"
    }
    func checkCalisthenics(_ weightTraining : WeightTraining) {
        if Calisthenics.calisthenicsArray.contains(weightTraining.weightTraining) {
            kgLabel.isHidden = true
        }
        else {
            kgLabel.isHidden = false
        }
    }
}
