//
//  FrameCategoryCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/27.
//

import UIKit

class FrameCategoryCell : UICollectionViewCell {
    let frameImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
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
        contentView.addSubview(frameImage)
    }
    
    func setupConstraints() {
        frameImage.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
