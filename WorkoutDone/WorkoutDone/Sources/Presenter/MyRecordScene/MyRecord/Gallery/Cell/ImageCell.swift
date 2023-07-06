//
//  FrameImageCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/27.
//

import UIKit
import SnapKit
import Then

class ImageCell : UICollectionViewCell {
    var image = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
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
        contentView.addSubview(image)
    }
    
    func setupConstraints() {
        image.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
