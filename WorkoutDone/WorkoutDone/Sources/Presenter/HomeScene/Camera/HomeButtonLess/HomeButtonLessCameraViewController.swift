//
//  HomeButtonLessCameraViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/15.
//

import UIKit
import SnapKit
import Then
import AVFoundation

class HomeButtonLessCameraViewController : BaseViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
            hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let deniedCameraView = PermissionDeniedView(permissionTitle: "카메라")
    private let authorizedCameraView = AuthorizedCameraView()
    
    private let gridToggleButton = GridToggleButton()


    
    override func viewDidLoad() {
        super.viewDidLoad()
//        previewView.backgroundColor = .red
//        [defaultFrameButton, manFirstUpperBodyFrameButton, manSecondUpperBodyFrameButton, manWholeBodyFrameButton, womanFirstUpperBodyFrameButton, womanSecondUpperBodyFrameButton, womanWholeBodyFrameButton].forEach {
//            $0.backgroundColor = .systemPink
//        }
        requestAuth()
    }
    override func setupLayout() {
        super.setupLayout()
        view.addSubviews(deniedCameraView, authorizedCameraView)
    }
    override func setComponents() {
        super.setComponents()
        view.backgroundColor = .colorFFFFFF
        let barButton = UIBarButtonItem()
        barButton.customView = gridToggleButton
        navigationItem.rightBarButtonItem = barButton
        navigationController?.isNavigationBarHidden = false
        deniedCameraView.isHidden = true
        authorizedCameraView.isHidden = true
    }
    override func setupConstraints() {
        super.setupConstraints()
        deniedCameraView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        authorizedCameraView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }

//    override func setupLayout() {
//        super.setupLayout()
//        view.addSubviews(previewView, frameImageView, frameScrollBackView, separateView, captureBackView, captureButton, switchCameraButton)
//        frameScrollBackView.addSubview(frameScrollView)
//        frameScrollView.addSubview(frameScrollContentView)
//        frameScrollContentView.addSubview(frameStackView)
//        [defaultFrameButton, manFirstUpperBodyFrameButton, manSecondUpperBodyFrameButton, manWholeBodyFrameButton, womanFirstUpperBodyFrameButton, womanSecondUpperBodyFrameButton, womanWholeBodyFrameButton].forEach {
//            frameStackView.addArrangedSubview($0)
//        }
//    }
//    override func setComponents() {
//        super.setComponents()
//
//
//        navigationController?.isNavigationBarHidden = false
//        [defaultFrameButton, manFirstUpperBodyFrameButton, manSecondUpperBodyFrameButton, manWholeBodyFrameButton, womanFirstUpperBodyFrameButton, womanSecondUpperBodyFrameButton, womanWholeBodyFrameButton].forEach {
//            frameButtons.append($0)
//        }
//        frameScrollView.showsVerticalScrollIndicator = false
//        defaultFrameButton.tag = FrameButtonType.defaultFrame.rawValue
//        manFirstUpperBodyFrameButton.tag = FrameButtonType.manFirstUpperBodyFrame.rawValue
//
//    }
//    override func setupConstraints() {
//        super.setupConstraints()
//        gridToggleButton.snp.makeConstraints {
//            $0.height.equalTo(29)
//            $0.width.equalTo(84)
//        }


//
//
//    }
    override func actions() {
        super.actions()
        deniedCameraView.permisstionButton.addTarget(self, action: #selector(permisstionButtonTapped), for: .touchUpInside)
        gridToggleButton.addTarget(self, action: #selector(gridToggleButtonTapped), for: .touchUpInside)
        authorizedCameraView.captureButton.addTarget(self, action: #selector(captureButtonTapped), for: .touchUpInside)
    }
    @objc func captureButtonTapped() {
        let homeButtonLessPressShutterViewController = HomeButtonLessPressShutterViewController()
        self.navigationController?.pushViewController(homeButtonLessPressShutterViewController, animated: false)
    }
    @objc func permisstionButtonTapped() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)

    }
    @objc func gridToggleButtonTapped(sender: UIButton!) {
        if gridToggleButton.isOnToggle {
            authorizedCameraView.frameImageView.isHidden = true
        }
        else {
            authorizedCameraView.frameImageView.isHidden = false
        }
        gridToggleButton.changeToggle()
        gridToggleButton.isOnToggle = !gridToggleButton.isOnToggle
    }
//    override func actions() {
//        super.actions()
//        [defaultFrameButton, manFirstUpperBodyFrameButton, manSecondUpperBodyFrameButton, manWholeBodyFrameButton, womanFirstUpperBodyFrameButton, womanSecondUpperBodyFrameButton, womanWholeBodyFrameButton].forEach {
//            $0.addTarget(self, action: #selector(frameButtonsTapped(sender: )), for: .touchUpInside)
//        }
//    }
    /// frameButton Tap
//    @objc func frameButtonsTapped(sender: UIButton) {
//        for button in frameButtons {
//            if button == sender {
//                button.layer.borderWidth = 1
//                button.layer.borderColor = UIColor.color7442FF.cgColor
//            }
//            else {
//                button.layer.borderColor = .none
//                button.layer.borderWidth = 0
//            }
//        }
//        switch sender.tag {
//        case FrameButtonType.defaultFrame.rawValue:
//            print("defalut")
//        case FrameButtonType.manFirstUpperBodyFrame.rawValue:
//            print("manFirst")
//        case FrameButtonType.manSecondUpperBodyFrame.rawValue:
//            print("manSecond")
//        case FrameButtonType.manWholeBodyFrame.rawValue:
//            print("manWhole")
//        case FrameButtonType.womanFirstUpperBodyFrame.rawValue:
//            print("womanFirst")
//        case FrameButtonType.womanSecondUpperBodyFrame.rawValue:
//            print("womanSecond")
//        case FrameButtonType.womanWholeBodyFraame.rawValue:
//            print("womanWhole")
//        default:
//            print("default")
//        }
//    }
    private func requestAuth() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            guard let self = self else { return }
            if granted {
                print("ok")
                self.requestAuthResponseView(granted: true) { _ in
                    DispatchQueue.main.async {
                        self.deniedCameraView.isHidden = true
                        self.authorizedCameraView.isHidden = false
                        print(self.authorizedCameraView.isHidden, "dd")
                    }
                }
            }
            else {
                print("no")
                self.requestAuthResponseView(granted: false) { _ in
                    DispatchQueue.main.async {
                        self.deniedCameraView.isHidden = false
                        self.authorizedCameraView.isHidden = true
                    }
                }
            }
        }
    }

    private func requestAuthResponseView(granted: Bool, completion : @escaping ((Bool) -> Void)) {
        if granted {
            completion(true)
        }
        else {
            completion(false)
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
