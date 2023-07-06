//
//  EmptyImageCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/11.
//

import UIKit
import SnapKit
import Then

class EmptyImageCell: UICollectionViewCell {
    private let emptyImageLabel = UILabel().then {
        $0.text = "아직 저장된 사진이 없습니다."
        $0.textColor = .color929292
        $0.font = .pretendard(.regular, size: 16)
    }
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ACTIONS
    func setupLayout() {
        contentView.addSubview(emptyImageLabel)
    }
    
    func setupConstraints() {
        emptyImageLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
