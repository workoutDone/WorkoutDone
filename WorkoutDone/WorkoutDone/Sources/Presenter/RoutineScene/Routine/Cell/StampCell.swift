//
//  StampCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/24.
//

import UIKit

class StampCell: UICollectionViewCell {
    var stampImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    // MARK: - ACTIONS
    func setupLayout() {
        contentView.addSubview(stampImage)
    }
    
    func setupConstraints() {
        stampImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
    }
}
