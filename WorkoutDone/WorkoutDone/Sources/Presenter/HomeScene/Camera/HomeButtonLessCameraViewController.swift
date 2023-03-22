//
//  HomeButtonLessCameraViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/15.
//

import UIKit
import SnapKit
import Then

class HomeButtonLessCameraViewController : BaseViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
            hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let previewView = PreviewView()
    
    private let captureButton = UIButton().then {
        $0.setImage(UIImage(named: "homeButtonLessCaptureButton"), for: .normal)
    }
    
    private let switchCameraButton = UIButton().then {
        $0.setImage(UIImage(named: "switchCamera"), for: .normal)
    }
    
    private let captureAgainButton = UIButton()
    
    private let frameImageView = UIImageView()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previewView.backgroundColor = .red
        [defaultFrameButton, manFirstUpperBodyFrameButton, manSecondUpperBodyFrameButton, manWholeBodyFrameButton, womanFirstUpperBodyFrameButton, womanSecondUpperBodyFrameButton, womanWholeBodyFrameButton].forEach {
            $0.backgroundColor = .systemPink
        }
    }

    override func setupLayout() {
        super.setupLayout()
        [previewView, frameImageView, frameScrollBackView, separateView, captureBackView, captureButton, switchCameraButton].forEach {
            view.addSubview($0)
        }
        frameScrollBackView.addSubview(frameScrollView)
        frameScrollView.addSubview(frameScrollContentView)
        frameScrollContentView.addSubview(frameStackView)
        [defaultFrameButton, manFirstUpperBodyFrameButton, manSecondUpperBodyFrameButton, manWholeBodyFrameButton, womanFirstUpperBodyFrameButton, womanSecondUpperBodyFrameButton, womanWholeBodyFrameButton].forEach {
            frameStackView.addArrangedSubview($0)
        }
    }
    override func setComponents() {
        super.setComponents()
        view.backgroundColor = .colorFFFFFF
        navigationController?.isNavigationBarHidden = false
        [defaultFrameButton, manFirstUpperBodyFrameButton, manSecondUpperBodyFrameButton, manWholeBodyFrameButton, womanFirstUpperBodyFrameButton, womanSecondUpperBodyFrameButton, womanWholeBodyFrameButton].forEach {
            frameButtons.append($0)
        }
        frameScrollView.showsVerticalScrollIndicator = false
        defaultFrameButton.tag = FrameButtonType.defaultFrame.rawValue
        manFirstUpperBodyFrameButton.tag = FrameButtonType.manFirstUpperBodyFrame.rawValue
        
    }
    override func setupConstraints() {
        super.setupConstraints()
        previewView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.frame.width * 4 / 3)
        }
        frameScrollBackView.snp.makeConstraints {
            $0.top.equalTo(previewView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(103)
        }
        frameScrollView.snp.makeConstraints {
            $0.centerY.equalTo(frameScrollBackView)
            $0.height.equalTo(75)
            $0.leading.equalTo(frameScrollBackView.snp.leading)
            $0.trailing.equalTo(frameScrollBackView.snp.trailing)
        }
        frameScrollContentView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(frameScrollView)
        }
        frameStackView.snp.makeConstraints {
            $0.top.bottom.equalTo(frameScrollContentView)
        }
        frameStackView.snp.makeConstraints {
            $0.top.bottom.equalTo(frameScrollContentView)
            $0.leading.equalTo(frameScrollView.snp.leading).offset(15)
            $0.trailing.equalTo(frameScrollView.snp.trailing).offset(-15)
        }
        [defaultFrameButton, manFirstUpperBodyFrameButton, manSecondUpperBodyFrameButton, manWholeBodyFrameButton, womanFirstUpperBodyFrameButton, womanSecondUpperBodyFrameButton, womanWholeBodyFrameButton].forEach {
            $0.snp.makeConstraints {
                $0.height.width.equalTo(75)
            }
        }
        separateView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(frameScrollBackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        captureBackView.snp.makeConstraints {
            $0.top.equalTo(separateView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        captureButton.snp.makeConstraints {
            $0.centerY.centerX.equalTo(captureBackView)
        }
        switchCameraButton.snp.makeConstraints {
            $0.centerY.equalTo(captureBackView)
            $0.trailing.equalToSuperview().offset(-26)
        }


    }
    override func actions() {
        super.actions()
        [defaultFrameButton, manFirstUpperBodyFrameButton, manSecondUpperBodyFrameButton, manWholeBodyFrameButton, womanFirstUpperBodyFrameButton, womanSecondUpperBodyFrameButton, womanWholeBodyFrameButton].forEach {
            $0.addTarget(self, action: #selector(frameButtonsTapped(sender: )), for: .touchUpInside)
        }
    }
    /// frameButton Tap
    @objc func frameButtonsTapped(sender: UIButton) {
        for button in frameButtons {
            if button == sender {
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.color7442FF.cgColor
            }
            else {
                button.layer.borderColor = .none
                button.layer.borderWidth = 0
            }
        }
        switch sender.tag {
        case FrameButtonType.defaultFrame.rawValue:
            print("defalut")
        case FrameButtonType.manFirstUpperBodyFrame.rawValue:
            print("manFirst")
        case FrameButtonType.manSecondUpperBodyFrame.rawValue:
            print("manSecond")
        case FrameButtonType.manWholeBodyFrame.rawValue:
            print("manWhole")
        case FrameButtonType.womanFirstUpperBodyFrame.rawValue:
            print("womanFirst")
        case FrameButtonType.womanSecondUpperBodyFrame.rawValue:
            print("womanSecond")
        case FrameButtonType.womanWholeBodyFraame.rawValue:
            print("womanWhole")
        default:
            print("default")
        }
    }
}

extension HomeButtonLessCameraViewController {
    enum FrameButtonType : Int {
        case defaultFrame = 1
        case manFirstUpperBodyFrame = 2
        case manSecondUpperBodyFrame = 3
        case manWholeBodyFrame = 4
        case womanFirstUpperBodyFrame = 5
        case womanSecondUpperBodyFrame = 6
        case womanWholeBodyFraame = 7
    }
}
