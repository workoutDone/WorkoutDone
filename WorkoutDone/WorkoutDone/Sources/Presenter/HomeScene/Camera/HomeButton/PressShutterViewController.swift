//
//  PressShutterViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/04/06.
//

import UIKit

class PressShutterViewController: BaseViewController {
    
    let cameraViewHeight: Int = 468
    
    var captureImage = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .green
    }
    
    private let backButton = BackButton()
    
    let againButton = UIButton().then {
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
    
    private let saveButton = UIButton().then {
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
    
    private let instaButton = UIButton().then {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupLayout() {
        [captureImage, backButton, againButton, againLabel, saveButton, saveLabel, instaButton, instaLabel].forEach {
            view.addSubview($0)
        }
        
        againButton.addSubview(againImage)
        saveButton.addSubview(saveImage)
        instaButton.addSubview(instaImage)
    }
    
    override func setupConstraints() {
        captureImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(cameraViewHeight)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(captureImage).offset(13.5)
            $0.leading.equalToSuperview().offset(16)
        }
        
        againButton.snp.makeConstraints {
            $0.top.equalTo(captureImage.snp.bottom).offset(36)
            $0.leading.equalToSuperview().offset(32)
            $0.width.height.equalTo(62)
        }

        againImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(31)
        }
        
        againLabel.snp.makeConstraints {
            $0.centerX.equalTo(againButton)
            $0.top.equalTo(againButton.snp.bottom).offset(10)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(againButton)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(62)
        }
        
        saveImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(41)
        }
        
        saveLabel.snp.makeConstraints {
            $0.centerX.equalTo(saveButton)
            $0.top.equalTo(saveButton.snp.bottom).offset(10)
        }
        
        instaButton.snp.makeConstraints {
            $0.top.equalTo(againButton)
            $0.trailing.equalToSuperview().offset(-32)
            $0.width.height.equalTo(62)
        }

        instaImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(34)
        }
        
        instaLabel.snp.makeConstraints {
            $0.centerX.equalTo(instaButton)
            $0.top.equalTo(instaButton.snp.bottom).offset(10)
        }
    }
    
    override func actions() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        againButton.addTarget(self, action: #selector(againButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func backButtonTapped(sender: UIButton!) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func againButtonTapped(sender: UIButton!) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func saveButtonTapped(sender: UIButton!) {
        print("x")
    }
}
