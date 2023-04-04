//
//  FrameCategoryCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/27.
//

import UIKit
import SnapKit
import Then

class FrameCategoryCell : UICollectionViewCell {
    let frameImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .yellow
    }
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupConstraints()
        
        layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ACTIONS
    func setupLayout() {
        contentView.addSubview(frameImage)
    }
    
    func setupConstraints() {
        frameImage.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
