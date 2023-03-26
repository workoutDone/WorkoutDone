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
    let basicLabel = UILabel().then {
        $0.text = "기본"
        $0.font = .pretendard(.regular, size: 18)
        $0.textColor = .color7442FF
    }
    
    var frameImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        //$0.backgroundColor = .systemGray5
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(frameImage)
        contentView.addSubview(basicLabel)
        
        layer.cornerRadius = 10
        
        basicLabel.isHidden = true
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        frameImage.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        basicLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
