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
import RxSwift
import RxCocoa

class ImageSelectionViewController : BaseViewController {
    private var viewModel = ImageSelectionViewModel()
    private var didLoad = PublishSubject<Void>()
    var selectedDate : Int?
    private var defaultImageButtonEvent = PublishSubject<Void>()
    
    private lazy var input = ImageSelectionViewModel.Input(
        loadView: didLoad.asDriver(onErrorJustReturn: ()),
        selectedDate: Driver.just(selectedDate!).asDriver(onErrorJustReturn: 0),
        defaultImageButtonTapped: defaultImageButtonEvent.asDriver(onErrorJustReturn: ()))
    private lazy var output = viewModel.transform(input: input)
    
    ///dismiss 시 사용될 CompletionHandler
    var completionHandler : ((Int) -> Void)?
    
    
    // MARK: - PROPERTIES
    private let cancelButton = UIButton().then {
        $0.setImage(UIImage(named: "cancelImage"), for: .normal)
    }
    private let defaultImageButton = UIButton().then {
        $0.setTitle("기본이미지로 ", for: .normal)
        $0.setImage(UIImage(named: "defaultPhotoImage"), for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
        $0.backgroundColor = .colorFFFFFF
        $0.setTitleColor(UIColor.color121212, for: .normal)
        $0.titleLabel?.font = .pretendard(.medium, size: 20)
        $0.layer.cornerRadius = 15
    }
    private let galleryButton = UIButton().then {
        $0.setTitle("갤러리에서 가져오기", for: .normal)
        $0.setImage(UIImage(named: "galleryImage"), for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
        $0.backgroundColor = .colorFFFFFF
        $0.setTitleColor(UIColor.color121212, for: .normal)
        $0.titleLabel?.font = .pretendard(.medium, size: 20)
        $0.layer.cornerRadius = 15
    }
    private let cameraButton = UIButton().then {
        $0.setTitle("사진 촬영하기", for: .normal)
        $0.backgroundColor = .colorFFFFFF
        $0.setImage(UIImage(named: "cameraImage"), for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
        $0.backgroundColor = .colorFFFFFF
        $0.setTitleColor(UIColor.color121212, for: .normal)
        $0.titleLabel?.font = .pretendard(.medium, size: 20)
        $0.layer.cornerRadius = 15
    }
    var rootView : HomeViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setComponents() {
    }
    override func setupLayout() {
        super.setupLayout()
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let visualEffetView = UIVisualEffectView(effect: blurEffect)
        view.backgroundColor = UIColor(hex: 0x000000, alpha: 0.15)
        visualEffetView.frame = view.frame
        view.addSubviews(visualEffetView, cancelButton, galleryButton, cameraButton, defaultImageButton)
    }
    override func setupConstraints() {
        super.setupConstraints()
        cancelButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-43)
            $0.height.width.equalTo(55)
        }
        galleryButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(cancelButton.snp.top).offset(-45)
            $0.height.equalTo(70)
        }
        cameraButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(galleryButton.snp.top).offset(-9)
            $0.height.equalTo(70)
        }
        defaultImageButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(70)
            $0.bottom.equalTo(cameraButton.snp.top).offset(-9)
        }
    }
    override func setupBinding() {
        super.setupBinding()
        
        output.checkFrameImageData.drive(onNext: { value in
            if value {
                self.defaultImageButton.isHidden = false
                print("데이터 x")
            }
            else {
                self.defaultImageButton.isHidden = true
            }
        })
        .disposed(by: disposeBag)
        
        output.deleteData.drive(onNext: {
            self.completionHandler?(self.selectedDate!)
            self.dismiss(animated: true)
        })
        .disposed(by: disposeBag)
        
        defaultImageButton.rx.tap
            .bind { _ in
                self.defaultImageButtonEvent.onNext(())
            }
            .disposed(by: disposeBag)
        didLoad.onNext(())
    }
    override func actions() {
        super.actions()
        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
        galleryButton.addTarget(self, action: #selector(galleryButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    @objc func cameraButtonTapped() {
        let device = Device.current
        print(device)
//        if DeviceManager.shared.isHomeButtonDevice() || DeviceManager.shared.isSimulatorIsHomeButtonDevice() {
//            print("홈버튼이 있는 기종")
//            let homeButtonCameraViewController = HomeButtonCameraViewController()
//            homeButtonCameraViewController.hidesBottomBarWhenPushed = true
//            dismiss(animated: false) {
//                self.rootView?.navigationController?.pushViewController(homeButtonCameraViewController, animated: false)
//            }
//        }
//        else {
            print("홈 버튼이 없는 기종")
            let homeButtonLessCameraViewController = HomeButtonLessCameraViewController()
            dismiss(animated: false) {
                self.rootView?.navigationController?.pushViewController(homeButtonLessCameraViewController, animated: true)
            }
//        }
    }
    @objc func galleryButtonTapped() {
        let photoGalleryViewController = PhotoGalleryViewController()
        dismiss(animated: false) {
            self.rootView?.navigationController?.pushViewController(photoGalleryViewController, animated: true)
        }
    }
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
}
