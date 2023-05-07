//
//  HomeButtonLessPhotoFrameTypeViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/01.
//

import UIKit


class HomeButtonLessPhotoFrameTypeViewController : BaseViewController {
    
    // MARK: - PROPERTIES
    private let saveButton = GradientButton(colors: [UIColor.color7442FF.cgColor, UIColor.color8E36FF.cgColor]).then {
        $0.setTitle("저장하기", for: .normal)
        $0.titleLabel?.font = .pretendard(.bold, size: 20)
        $0.setTitleColor(UIColor.colorFFFFFF, for: .normal)
    }
    private let selectedImageView = UIImageView().then {
        $0.backgroundColor = .red
    }
    
    private let photoFrameBackView = UIView()
    private let saveButtonAreaBackView = UIView()
    private let separateView = UIView().then {
        $0.backgroundColor = UIColor.colorDBDBDB
    }
    
    private let photoFrameButtonsScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let photoFrameButtonsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 10
    }
    private let photoFrameButtonsScrollContentView = UIView()
    ///프레임 타입 버튼
    private let defaultFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .colorE2E2E2
    }
    
    private let manFirstUpperBodyFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .colorE2E2E2
    }
    
    private let manSecondUpperBodyFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .colorE2E2E2
    }
    
    private let manWholeBodyFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .colorE2E2E2
    }
    
    private let womanFirstUpperBodyFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .colorE2E2E2
    }
    
    private let womanSecondUpperBodyFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .colorE2E2E2
    }
    
    private let womanWholeBodyFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .colorE2E2E2
    }
    private var frameButtons = [UIButton]()
    
    
    
    // MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func setComponents() {
        super.setComponents()
        view.backgroundColor = .colorFFFFFF
        navigationItem.title = "프레임 선택"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.color121212]
    }
    
    override func setupLayout() {
        super.setupLayout()
        view.addSubviews(selectedImageView, separateView, saveButtonAreaBackView, photoFrameBackView)
        saveButtonAreaBackView.addSubview(saveButton)
        photoFrameBackView.addSubview(photoFrameButtonsScrollView)
        photoFrameButtonsScrollView.addSubview(photoFrameButtonsScrollContentView)
        photoFrameButtonsScrollContentView.addSubview(photoFrameButtonsStackView)
        photoFrameButtonsStackView.addArrangedSubviews(defaultFrameButton, manFirstUpperBodyFrameButton, manSecondUpperBodyFrameButton, manWholeBodyFrameButton, womanFirstUpperBodyFrameButton, womanSecondUpperBodyFrameButton, womanWholeBodyFrameButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        selectedImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.frame.width * 4 / 3)
        }
        photoFrameBackView.snp.makeConstraints {
            $0.top.equalTo(selectedImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(103)
        }
        separateView.snp.makeConstraints {
            $0.top.equalTo(photoFrameBackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        saveButtonAreaBackView.snp.makeConstraints {
            $0.top.equalTo(separateView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        saveButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(58)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        photoFrameButtonsScrollView.snp.makeConstraints {
            $0.centerY.equalTo(photoFrameBackView)
            $0.height.equalTo(75)
            $0.leading.trailing.equalToSuperview()
        }
        photoFrameButtonsScrollContentView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        photoFrameButtonsStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        
        
        defaultFrameButton.snp.makeConstraints {
            $0.height.width.equalTo(75)
        }
        manFirstUpperBodyFrameButton.snp.makeConstraints {
            $0.height.width.equalTo(75)
        }
        manSecondUpperBodyFrameButton.snp.makeConstraints {
            $0.height.width.equalTo(75)
        }
        manWholeBodyFrameButton.snp.makeConstraints {
            $0.height.width.equalTo(75)
        }
        womanFirstUpperBodyFrameButton.snp.makeConstraints {
            $0.height.width.equalTo(75)
        }
        womanSecondUpperBodyFrameButton.snp.makeConstraints {
            $0.height.width.equalTo(75)
        }
        womanWholeBodyFrameButton.snp.makeConstraints {
            $0.height.width.equalTo(75)
        }
    }
    
    // MARK: - ACTIONS
    override func actions() {
        super.actions()
        defaultFrameButton.addTarget(self, action: #selector(defaultFrameButtonTapped), for: .touchUpInside)
    }
    @objc func defaultFrameButtonTapped() {
        print("ㄴㄴ")
    }
}
// MARK: - EXTENSIONs

extension HomeButtonLessPhotoFrameTypeViewController {
    
}

