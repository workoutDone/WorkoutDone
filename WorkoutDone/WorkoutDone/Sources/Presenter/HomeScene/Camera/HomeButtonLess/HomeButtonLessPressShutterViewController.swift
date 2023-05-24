//
//  HomeButtonLessPressShutterViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/23.
//

import UIKit
import SnapKit
import Then
class HomeButtonLessPressShutterViewController : BaseViewController {
    
    
    // MARK: - PROPERTIES
    
    var captureImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private let againButton = UIButton().then {
        $0.backgroundColor = .colorE6E0FF
        $0.layer.cornerRadius = 31
    }
    private let againImage = UIImageView().then {
        $0.image = UIImage(named: "again")
    }
    
    private let againLabel = UILabel().then {
        $0.text = "다시 찍기"
        $0.font = .pretendard(.medium, size: 14)
        $0.textColor = .color121212
    }
    
    private lazy var againButtonStackView : UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [againButton, againLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
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
        $0.textColor = .color121212
    }
    
    private lazy var saveButtonStackView : UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [saveButton, saveLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private let instaButton = UIButton().then {
        $0.backgroundColor = .colorE6E0FF
        $0.layer.cornerRadius = 31
    }
    
    private lazy var instaImage = UIImageView().then {
        $0.image = UIImage(named: "insta")
    }
    
    private let instaLabel = UILabel().then {
        $0.text = "인스타 업로드"
        $0.font = .pretendard(.medium, size: 14)
        $0.textColor = .color121212
    }
    
    private lazy var instaButtonStackView : UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [instaButton, instaLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private let buttonBackView = UIView()
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        captureImageView.backgroundColor = .blue
    }
    override func setComponents() {
        view.backgroundColor = .colorFFFFFF
        

    }

    
    override func setupLayout() {
        view.addSubviews(captureImageView, buttonBackView)
        buttonBackView.addSubviews(againButtonStackView, saveButtonStackView, instaButtonStackView)
        saveButton.addSubview(saveImage)
        instaButton.addSubview(instaImage)
        againButton.addSubview(againImage)
    }
    override func setupConstraints() {
        captureImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.size.width * 4 / 3)
        }
        buttonBackView.snp.makeConstraints {
            $0.top.equalTo(captureImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        againButtonStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(34)
        }
        againButton.snp.makeConstraints {
            $0.height.width.equalTo(62)
        }
        againImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(31)
        }
        
        saveButtonStackView.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        saveButton.snp.makeConstraints {
            $0.height.width.equalTo(62)
        }
        saveImage.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.width.height.equalTo(42)
        }
        instaButtonStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(34)
            $0.centerY.equalToSuperview()
        }
        instaButton.snp.makeConstraints {
            $0.height.width.equalTo(62)
        }
        instaImage.snp.makeConstraints {
            $0.height.width.equalTo(34)
            $0.centerY.centerX.equalToSuperview()
        }
    }
    
    // MARK: - ACTIONS
    override func actions() {
        
    }
}
// MARK: - EXTENSIONs
extension HomeButtonLessPressShutterViewController {
    
}

