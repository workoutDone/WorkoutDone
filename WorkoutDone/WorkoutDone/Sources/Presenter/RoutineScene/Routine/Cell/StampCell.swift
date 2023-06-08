//
//  StampCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/24.
//

import UIKit

class StampCell: UICollectionViewCell {
    var stampImage = UIImageView().then {
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.colorFFFFFF.cgColor
        $0.layer.cornerRadius = 46 / 2
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
        contentView.addSubview(stampImage)
    }
    
    func setupConstraints() {
        stampImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(46)
        }
    }
}
