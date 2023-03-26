//
//  BackButton.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/24.
//

import UIKit
import SnapKit
import Then

class BackButton: UIButton {
    private let backButtonImage = UIImageView().then {
        $0.image = UIImage(named: "backButton")
    }
    
    private let backButtonLabel = UILabel().then {
        $0.text = "뒤로가기"
        $0.textColor = .colorFFFFFF
        $0.font = .pretendard(.regular, size: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setLayout()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        self.addSubview(backButtonImage)
        self.addSubview(backButtonLabel)
    }
    
    func setConstraints() {
        self.snp.makeConstraints {
            $0.width.equalTo(64.5)
            $0.height.equalTo(17)
        }
        
        backButtonImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(9)
            $0.height.equalTo(16)
        }

        backButtonLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(backButtonImage.snp.trailing).offset(6.51)
        }
    }
}
