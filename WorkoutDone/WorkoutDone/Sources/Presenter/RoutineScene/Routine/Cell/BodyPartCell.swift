//
//  BodyPartCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/17.
//

import UIKit

class BodyPartCell: UICollectionViewCell {
    var bodyPartLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .colorC8B4FF
        $0.textAlignment = .center
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
        contentView.addSubview(bodyPartLabel)
    }
    
    func setupConstraints() {
        bodyPartLabel.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
