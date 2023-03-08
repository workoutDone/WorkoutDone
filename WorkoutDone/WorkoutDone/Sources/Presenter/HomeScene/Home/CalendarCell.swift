//
//  CalendarCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/07.
//

import UIKit
import SnapKit
import Then

class CalendarCell: UICollectionViewCell {
    let dayLabel = UILabel().then {
        $0.textColor = .colorF3F3F3
        $0.font = .pretendard(.light, size: 14)
        $0.text = "1"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(dayLabel)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        dayLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
