//
//  CreateWeightTrainingButton.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/06/19.
//

import UIKit

class CreateWeightTrainingButton: UIButton {
    
    private let borderImage = UIImageView().then {
        $0.image = UIImage(named: "border")
    }
    
    private let createView = UIView().then {
        $0.layer.cornerRadius = 42 / 2
        $0.backgroundColor = .colorF8F6FF
    }
    
    private let createImage = UIImageView().then {
        $0.image = UIImage(named: "create")
        $0.tintColor = .colorC8B4FF
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        [borderImage, createView].forEach {
            self.addSubview($0)
        }
        createView.addSubview(createImage)
    }
    
    func setupConstraints() {
        borderImage.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        createView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(42)
        }
        
        createImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(14)
        }
    }
    
}
