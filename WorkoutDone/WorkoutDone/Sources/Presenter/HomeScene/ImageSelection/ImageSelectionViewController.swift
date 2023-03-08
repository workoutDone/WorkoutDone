//
//  ImageSelectionViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/07.
//

import UIKit
import SnapKit
import Then
import DeviceKit

class ImageSelectionViewController : BaseViewController {
    // MARK: - PROPERTIES
    private let cancelButton = UIButton().then {
        $0.setImage(UIImage(named: ""), for: .normal)
    }
    private let galleryButton = UIButton().then {
        $0.setTitle("갤러리에서 가져오기", for: .normal)
        $0.backgroundColor = .colorFFFFFF
    }
    private let cameraButton = UIButton().then {
        $0.setTitle("사진 촬영하기", for: .normal)
        $0.backgroundColor = .colorFFFFFF
    }
    private let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
    var rootViewController : HomeViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setupLayout() {
        super.setupLayout()
        let visualEffetView = UIVisualEffectView(effect: blurEffect)
        visualEffetView.frame = view.frame
        [visualEffetView, cancelButton, galleryButton, cameraButton].forEach {
            view.addSubview($0)
        }
    }
    override func setupConstraints() {
        super.setupConstraints()
        cancelButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-43)
            $0.height.width.equalTo(42)
        }
        galleryButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        cameraButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(galleryButton.snp.top).offset(-10)
            $0.height.equalTo(70)
        }
    }
    override func setupBinding() {
        super.setupBinding()
    }
    override func actions() {
        super.actions()
        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
        galleryButton.addTarget(self, action: #selector(galleryButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    @objc func cameraButtonTapped() {
//        let device = Device.current
//        print(device)
//        if DeviceManager.shared.isHomeButtonDevice() || DeviceManager.shared.isSimulatorIsHomeButtonDevice() {
//            print("홈버튼이 있는 기종")
//            let homeButtonCameraViewController = HomeButtonCameraViewController()
//            dismiss(animated: false) {
//                self.rootView?.navigationController?.pushViewController(homeButtonCameraViewController, animated: true)
//            }
//        }
//        else {
//            print("홈 버튼이 없는 기종")
//            let homeButtonLessCameraViewController = HomeButtonLessCameraViewController()
//            navigationController?.pushViewController(homeButtonLessCameraViewController, animated: true)
//            dismiss(animated: false) {
//                self.rootView?.navigationController?.pushViewController(homeButtonLessCameraViewController, animated: true)
//            }
//        }
    }
    @objc func galleryButtonTapped() {
//        let photoViewController = PhotoViewController()
//        dismiss(animated: false) {
//            self.rootView?.navigationController?.pushViewController(photoViewController, animated: true)
//        }
    }
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
}
