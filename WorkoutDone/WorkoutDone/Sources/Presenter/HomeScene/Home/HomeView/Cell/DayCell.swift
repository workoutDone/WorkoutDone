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
        $0.textColor = .colorF3F3F3
        $0.font = .pretendard(.light, size: 14)
    }
    
    var workOutDoneImage = UIImageView().then {
        $0.image = UIImage(named: "workOutDone")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(dayLabel)
        contentView.addSubview(workOutDoneImage)
        
        workOutDoneImage.isHidden = true
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        dayLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        workOutDoneImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(29)
        }
    }
}
