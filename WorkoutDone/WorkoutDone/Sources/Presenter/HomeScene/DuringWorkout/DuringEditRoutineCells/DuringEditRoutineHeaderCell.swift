//
//  DuringEditRoutineHeaderCell.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/28.
//

import UIKit

class DuringEditRoutineHeaderCell : UITableViewHeaderFooterView {
    static let headerViewID = "DuringEditRoutineHeaderCell"
    
    private let backView = UIView()
    
    private let titleLabel = UILabel().then {
        $0.text = "오늘 해야 할 운동"
        $0.textColor = .color929292
        $0.font = .pretendard(.regular, size: 14)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupLayout() {
        self.addSubview(backView)
        backView.addSubview(titleLabel)
    }
    private func setupConstraints() {
        backView.snp.makeConstraints {
            $0.height.equalTo(46)
            $0.top.leading.trailing.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(28)
        }
    }
}
