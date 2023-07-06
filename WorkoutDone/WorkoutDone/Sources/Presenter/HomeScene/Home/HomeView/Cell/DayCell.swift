//
//  DayCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/07.
//

import UIKit
import SnapKit
import Then

class DayCell: UICollectionViewCell {
    let dayLabel = UILabel().then {
        $0.textColor = .color121212
        $0.font = .pretendard(.light, size: 16)
        $0.textAlignment = .center
    }
    
    var selectedDateImage = UIImageView().then {
        $0.image = UIImage(named: "selectDate")
    }
    
    var stampImage = UIImageView().then {
        $0.image = UIImage(named: "stampVImage")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(dayLabel)
        contentView.addSubview(selectedDateImage)
        contentView.addSubview(stampImage)
        
        selectedDateImage.isHidden = true
        stampImage.isHidden = true
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        dayLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(stampImage)
        }
        
        selectedDateImage.snp.makeConstraints {
            $0.centerX.centerY.equalTo(stampImage)
            $0.width.height.equalTo(29)
        }
        
        stampImage.snp.makeConstraints {
            $0.centerX.centerY.equalTo(contentView)
            $0.width.height.equalTo(41)
        }
    }
}
