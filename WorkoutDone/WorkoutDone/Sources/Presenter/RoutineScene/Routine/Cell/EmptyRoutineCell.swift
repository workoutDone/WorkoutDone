//
//  EmptyRoutineCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/17.
//

import UIKit

class EmptyRoutineCell : UITableViewCell {
    private let emptyRoutineLabel = UILabel().then {
        $0.text = "나의 루틴 목록이 비어있어요.\n새로운 루틴을 만들어보세요!"
        $0.textColor = .color929292
        $0.font = .pretendard(.regular, size: 16)
        $0.numberOfLines = 0
    }
    
    // MARK: - LIFECYCLE
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ACTIONS
    func setupLayout() {
        self.addSubview(emptyRoutineLabel)
    }
    
    func setupConstraints() {
        emptyRoutineLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

