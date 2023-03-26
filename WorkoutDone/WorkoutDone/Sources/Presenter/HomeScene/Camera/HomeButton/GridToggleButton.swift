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
    var isOnToggle: Bool = true
    
    private let gridToggleLabel = UILabel().then {
        $0.text = "그리드 ON"
        $0.textColor = .colorFFFFFF
        $0.font = .pretendard(.regular, size: 14)
    }

    private let gridToggleCircleImage = UIImageView().then {
        $0.image = UIImage(named: "gridToggleCircle")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setLayout()
        setConstraints()
        
        self.backgroundColor = .color7442FF
        self.layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        self.addSubview(gridToggleLabel)
        self.addSubview(gridToggleCircleImage)
    }
    
    func setConstraints() {
        self.snp.makeConstraints {
            $0.width.equalTo(103)
            $0.height.equalTo(30)
        }

        gridToggleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(9)
        }

        gridToggleCircleImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-1.68)
            $0.width.height.equalTo(26.64)
        }
    }
    
    func changeToggle() {
        if !isOnToggle {
            gridToggleLabel.text = "그리드 ON"
            gridToggleLabel.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().offset(9)
            }

            gridToggleCircleImage.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().offset(-1.68)
                $0.width.height.equalTo(26.64)
            }
            self.backgroundColor = .color7442FF
            gridToggleLabel.textColor = .colorFFFFFF
        } else {
            gridToggleLabel.text = "그리드 OFF"
            gridToggleLabel.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().offset(-7)
            }
            gridToggleCircleImage.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().offset(1.68)
                $0.width.height.equalTo(26.64)
            }
            self.backgroundColor = .systemGray3
            gridToggleLabel.textColor = .colorFFFFFF
        }
    }
}
