//
//  RoutineEditorCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/24.
//

import UIKit
import SnapKit
import Then

class RoutineEditorCell: UITableViewCell {
    private let bodyPartView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.color7442FF.cgColor
        $0.layer.cornerRadius = 23 / 2
    }
    
    let bodyPartLabel = UILabel().then {
        $0.text = "어깨"
        $0.textColor = .color7442FF
        $0.font = .pretendard(.regular, size: 14)
    }
    
    let weightTrainingLabel = UILabel().then {
        $0.text = "배틀 로프"
        $0.font = .pretendard(.regular, size: 16)
    }
    
    let editImage = UIImageView().then {
        $0.image = UIImage(named: "edit")
    }

    // MARK: - LIFECYCLE
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        setupConstraints()
        
        self.backgroundColor = .clear
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.colorC8B4FF.cgColor
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .colorFFFFFF
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 7, left: 10, bottom: 7, right: 10))
     
    }
    
    
    // MARK: - ACTIONS
    func setupLayout() {
        [bodyPartView, weightTrainingLabel, editImage].forEach {
            contentView.addSubview($0)
        }

        bodyPartView.addSubview(bodyPartLabel)
    }
    
    func setupConstraints() {
        bodyPartView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(37)
            $0.height.equalTo(23)
        }
        
        bodyPartLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(bodyPartView)
        }
        
        weightTrainingLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        editImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(15.5)
            $0.height.equalTo(9.3)
        }
    }
}
