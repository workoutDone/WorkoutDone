//
//  GridToggleButton.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/24.
//

import UIKit
import SnapKit
import Then

class GridToggleButton: UIButton {
    var isOnToggle: Bool = false
    
    private let gridToggleLabel = UILabel().then {
        $0.text = "그리드 OFF"
        $0.textColor = .color5E5E5E
        $0.font = .pretendard(.regular, size: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setLayout()
        setConstraints()
        
        self.backgroundColor = .colorFFFFFF04
        self.layer.cornerRadius = 14.5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.color363636.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        self.addSubview(gridToggleLabel)
    }
    
    func setConstraints() {
        self.snp.makeConstraints {
            $0.width.equalTo(84)
            $0.height.equalTo(29)
        }

        gridToggleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    func changeToggle() {
        if isOnToggle {
            gridToggleLabel.text = "그리드 OFF"
            self.backgroundColor = .colorFFFFFF04
            self.layer.borderColor = UIColor.color363636.cgColor
            gridToggleLabel.textColor = .color5E5E5E
        } else {
            gridToggleLabel.text = "그리드 ON"
            self.backgroundColor = .colorFFFFFF08
            self.layer.borderColor = UIColor.color7442FF.cgColor
            gridToggleLabel.textColor = .color612CF8
        }
    }
}
