//
//  FrameCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/18.
//

import UIKit
import SnapKit
import Then

class FrameCell: UICollectionViewCell {
    // MARK: - PROPERTIES
    let frameImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .systemGray5
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(frameImage)
        
        layer.cornerRadius = 10
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        frameImage.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
