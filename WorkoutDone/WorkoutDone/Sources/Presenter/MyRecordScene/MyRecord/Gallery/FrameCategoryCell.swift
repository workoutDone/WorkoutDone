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
        $0.backgroundColor = .yellow
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderWidth = 2
                layer.borderColor = UIColor.color7442FF.cgColor
            } else {
                layer.borderWidth = 0
            }
        }
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
