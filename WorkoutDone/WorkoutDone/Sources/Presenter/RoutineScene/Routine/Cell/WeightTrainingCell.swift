//
//  WeightTrainingCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/17.
//

import UIKit

class WeightTrainingCell : UITableViewCell {
    var weightTraingView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .colorF6F6F6
    }
    
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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        setupConstraints()
        
        selectedIndexView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0))
    }
    
    // MARK: - ACTIONS
    func setupLayout() {
        contentView.addSubview(weightTraingView)
        weightTraingView.addSubview(weightTrainingLabel)
        contentView.addSubview(selectedIndexView)
        selectedIndexView.addSubview(selectedIndexLabel)
    }
    
    func setupConstraints() {
        weightTraingView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(40)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-40)
        }
        
        weightTrainingLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(weightTraingView)
        }
        
        selectedIndexView.snp.makeConstraints {
            $0.top.equalTo(weightTraingView).offset(-8)
            $0.trailing.equalTo(weightTraingView).offset(8)
            $0.width.height.equalTo(24)
        }
        
        selectedIndexLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(selectedIndexView)
        }
    }
}
