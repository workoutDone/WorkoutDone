//
//  DayOfTheWeekCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/09.
//

import UIKit

class DayOfTheWeekCell: UICollectionViewCell {
    // MARK: - PROPERTIES
    var dayOfTheWeekLabel = UILabel().then {
        $0.textColor = .color121212
        $0.font = .pretendard(.regular, size: 12)
        $0.textAlignment = .center
    }
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(dayOfTheWeekLabel)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ACTIONS
    func setLayout() {
        dayOfTheWeekLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
