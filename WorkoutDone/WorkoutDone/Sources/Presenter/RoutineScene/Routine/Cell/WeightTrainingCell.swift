//
//  WeightTrainingCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/17.
//

import UIKit

class WeightTrainingCell : UICollectionViewCell {
    var weightTrainingLabel = UILabel().then {
        $0.text = "벤치 프레스"
        $0.textColor = .color363636
        $0.textAlignment = .center
        $0.font = .pretendard(.regular, size: 16)
    }
    
    var selectedIndexView = UIView().then {
        $0.backgroundColor = .color7442FF
        $0.layer.cornerRadius = 12
    }
    
    var selectedIndexLabel = UILabel().then {
        $0.text = "0"
        $0.textColor = .colorFFFFFF
        $0.font = .pretendard(.semiBold, size: 15)
    }
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.colorCCCCCC.cgColor
        
        setupLayout()
        setupConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ACTIONS
    func setupLayout() {
        contentView.addSubview(weightTrainingLabel)
        contentView.addSubview(selectedIndexView)
        selectedIndexView.addSubview(selectedIndexLabel)
    }
    
    func setupConstraints() {
        weightTrainingLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        selectedIndexView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-8)
            $0.trailing.equalToSuperview().offset(8)
            $0.width.height.equalTo(24)
        }
        
        selectedIndexLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(selectedIndexView)
        }
    }
}
