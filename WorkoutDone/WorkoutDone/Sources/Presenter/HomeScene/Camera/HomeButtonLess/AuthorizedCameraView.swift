//
//  AuthorizedCameraView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/23.
//

import UIKit

class AuthorizedCameraView : BaseUIView {
    // MARK: - PROPERTIES
    private lazy var previewView = PreviewView()


    let frameImageView = UIImageView().then {
        $0.image = UIImage(named: "cameraFrameImage")
    }
    
    private let gridImageView = UIImageView()


    private let frameTypeBaseView = UIView()

    ///프레임 타입 버튼
    private let defaultFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
    }

    private let manFirstUpperBodyFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
    }

    private let manSecondUpperBodyFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
    }

    private let manWholeBodyFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
    }

    private let womanFirstUpperBodyFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
    }

    private let womanSecondUpperBodyFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
    }

    private let womanWholeBodyFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
    }

    private var frameButtons = [UIButton]()

    private let frameScrollBackView = UIView().then {
        $0.backgroundColor = .colorFFFFFF
    }

    private let frameScrollView = UIScrollView().then {
        $0.backgroundColor = .colorFFFFFF
    }

    private let frameScrollContentView = UIView()

    private let frameStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 14
    }
    private let separateView = UIView().then {
        $0.backgroundColor = .colorDBDBDB
    }
    private let captureBackView = UIView()
    
    
    private let captureButton = UIButton().then {
        $0.setImage(UIImage(named: "homeButtonLessCaptureButton"), for: .normal)
    }

    private let switchCameraButton = UIButton().then {
        $0.setImage(UIImage(named: "switchCamera"), for: .normal)
    }
    
    override func setUI() {
        super.setUI()
        previewView.backgroundColor = .blue
        frameImageView.isHidden = true
        [defaultFrameButton, manFirstUpperBodyFrameButton, manSecondUpperBodyFrameButton, manWholeBodyFrameButton, womanFirstUpperBodyFrameButton, womanSecondUpperBodyFrameButton, womanWholeBodyFrameButton].forEach {
            $0.backgroundColor = .colorE2E2E2
        }
        frameScrollView.showsHorizontalScrollIndicator = false
    }
    override func setupLayout() {
        super.setupLayout()
        self.addSubviews(previewView, frameScrollBackView, separateView, captureBackView)
        previewView.addSubviews(frameImageView)
        frameScrollBackView.addSubview(frameScrollView)
        frameScrollView.addSubview(frameScrollContentView)
        frameScrollContentView.addSubview(frameStackView)
        [defaultFrameButton, manFirstUpperBodyFrameButton, manSecondUpperBodyFrameButton, manWholeBodyFrameButton, womanFirstUpperBodyFrameButton, womanSecondUpperBodyFrameButton, womanWholeBodyFrameButton].forEach {
            frameStackView.addArrangedSubview($0)
        }
        captureBackView.addSubviews(captureButton, switchCameraButton)
    }
    override func setupConstraints() {
        super.setupConstraints()
        
        previewView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.size.width * 4 / 3)
        }
        frameImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        frameScrollBackView.snp.makeConstraints {
            $0.top.equalTo(previewView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        frameScrollView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(75)
        }
        frameScrollContentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        frameStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        [defaultFrameButton, manFirstUpperBodyFrameButton, manSecondUpperBodyFrameButton, manWholeBodyFrameButton, womanFirstUpperBodyFrameButton, womanSecondUpperBodyFrameButton, womanWholeBodyFrameButton].forEach {
            $0.snp.makeConstraints {
                $0.height.width.equalTo(75)
            }
        }
        separateView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
            $0.top.equalTo(frameScrollBackView.snp.bottom)
        }
        captureBackView.snp.makeConstraints {
            $0.top.equalTo(separateView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        captureButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(60)
        }
        switchCameraButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(26)
            $0.height.width.equalTo(42)
        }
    }
}
//[previewView, frameImageView, frameScrollBackView, separateView, captureBackView, captureButton, switchCameraButton].forEach {
//    view.addSubview($0)
//}
//frameScrollBackView.addSubview(frameScrollView)
//frameScrollView.addSubview(frameScrollContentView)
//frameScrollContentView.addSubview(frameStackView)
//[defaultFrameButton, manFirstUpperBodyFrameButton, manSecondUpperBodyFrameButton, manWholeBodyFrameButton, womanFirstUpperBodyFrameButton, womanSecondUpperBodyFrameButton, womanWholeBodyFrameButton].forEach {
//    frameStackView.addArrangedSubview($0)
//}
