//
//  DuringEditRoutineTableViewCell.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/28.
//

import UIKit
import SnapKit
import Then

class DuringEditRoutineTableViewCell : UITableViewCell {
    static let identifier = "DuringEditRoutineTableViewCell"
    
    private let backView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .colorF8F6FF
    }
    
    private let workoutCategoryBorderView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color7442FF.cgColor
    }
    
    let workoutCategoryLabel = UILabel().then {
        $0.text = "어깨"
        $0.font = .pretendard(.regular, size: 14)
        $0.textColor = .color7442FF
    }
    
    let workoutTitleLabel = UILabel().then {
        $0.text = "배틀 로프"
        $0.font = .pretendard(.regular, size: 16)
        $0.textColor = .color121212
    }
    
    private let sandwichImageView = UIImageView().then {
        $0.image = UIImage(named: "sandwichImage")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStyle()
        setLayout()
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0))
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setStyle() {
        contentView.backgroundColor = .colorFFFFFF
        workoutCategoryBorderView.layer.cornerRadius = 23 / 2
    }
    func setLayout() {
        contentView.addSubview(backView)
        backView.addSubviews(workoutCategoryBorderView, workoutTitleLabel, sandwichImageView)
        workoutCategoryBorderView.addSubview(workoutCategoryLabel)
        
        backView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        workoutCategoryBorderView.snp.makeConstraints {
            $0.height.equalTo(23)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        workoutCategoryLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(6)
        }
        workoutTitleLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        sandwichImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}
