//
//  MonthCollectionHeaderView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/30.
//

import UIKit
import SnapKit
import Then

class MonthHeaderView : UICollectionReusableView {
    let monthLabel = UILabel().then {
        $0.text = "10월"
        $0.font = .pretendard(.semiBold, size: 18)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(monthLabel)
    }
    
    func setupConstraints() {
        monthLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
    }
}
