//
//  OnboardingCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/03.
//

import UIKit
import SnapKit
import Then

class OnboardingCell : UICollectionViewCell {
    
    // MARK: - PROPERTIES
    let onboardingImage = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    let onboardingText = UILabel().then {
        $0.font = .pretendard(.regular, size: 16)
    }
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(onboardingImage)
        addSubview(onboardingText)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ACTIONS
    func setLayout() {
        onboardingImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalTo(contentView.frame.width)
            $0.height.equalTo(486)
        }
        
        onboardingText.snp.makeConstraints() {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(onboardingImage.snp.bottom).offset(46)
        }
    }
}
