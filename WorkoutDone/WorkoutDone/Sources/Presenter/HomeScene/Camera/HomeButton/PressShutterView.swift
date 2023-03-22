//
//  PressShutterView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/18.
//

import UIKit
import SnapKit
import Then

class PressShutterView : BaseUIView {
    private let againButton = UIButton()
    
    private let againView = UIView().then {
        $0.backgroundColor = .colorE6E0FF
        $0.layer.cornerRadius = 31
    }
    
    private let againImage = UIImageView().then {
        $0.image = UIImage(named: "again")
    }
    
    private let againLabel = UILabel().then {
        $0.text = "다시 찍기"
        $0.font = .pretendard(.medium, size: 14)
    }
    
    private let saveButton = UIButton()
    
    private let saveView = UIView().then {
        $0.backgroundColor = .colorE6E0FF
        $0.layer.cornerRadius = 31
    }
    
    private let saveImage = UIImageView().then {
        $0.image = UIImage(named: "save")
    }
    
    private let saveLabel = UILabel().then {
        $0.text = "저장하기"
        $0.font = .pretendard(.medium, size: 14)
    }
    
    private let instaButton = UIButton()

    private let instaView = UIView().then {
        $0.backgroundColor = .colorE6E0FF
        $0.layer.cornerRadius = 31
    }
    
    private let instaImage = UIImageView().then {
        $0.image = UIImage(named: "insta")
    }
    
    private let instaLabel = UILabel().then {
        $0.text = "인스타 업로드"
        $0.font = .pretendard(.medium, size: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupLayout() {
        super.setupLayout()

        self.addSubview(againView)
        againView.addSubview(againImage)
        againView.addSubview(againButton)
        self.addSubview(againLabel)
        
        self.addSubview(saveView)
        saveView.addSubview(saveImage)
        saveView.addSubview(saveButton)
        self.addSubview(saveLabel)
        
        self.addSubview(instaView)
        instaView.addSubview(instaImage)
        instaView.addSubview(instaButton)
        self.addSubview(instaLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()

        againView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(36)
            $0.leading.equalToSuperview().offset(32)
            $0.width.height.equalTo(62)
        }
        
        againButton.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }

        againImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(31)
        }
        
        againLabel.snp.makeConstraints {
            $0.centerX.equalTo(againView)
            $0.top.equalTo(againView.snp.bottom).offset(10)
        }
        
        saveView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(36)
            $0.width.height.equalTo(62)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }

        saveImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(41)
        }
        
        saveLabel.snp.makeConstraints {
            $0.centerX.equalTo(saveView)
            $0.top.equalTo(saveView.snp.bottom).offset(10)
        }
        
        instaView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(36)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(62)
        }
        
        instaButton.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }

        instaImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(34)
        }
        
        instaLabel.snp.makeConstraints {
            $0.centerX.equalTo(instaView)
            $0.top.equalTo(instaView.snp.bottom).offset(10)
        }
    }
    
    func setAction() {
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
    }
    
    
    @objc func saveButtonTapped(sender: UIButton!) {
        print("x")
    }
}
