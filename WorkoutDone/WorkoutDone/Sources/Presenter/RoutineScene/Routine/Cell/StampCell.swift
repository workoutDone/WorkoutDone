//
//  StampCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/24.
//

import UIKit

class StampCell: UICollectionViewCell {
    var stampImage = UIImageView().then {
        $0.backgroundColor = .colorCCCCCC
        $0.layer.cornerRadius = 20
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
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
