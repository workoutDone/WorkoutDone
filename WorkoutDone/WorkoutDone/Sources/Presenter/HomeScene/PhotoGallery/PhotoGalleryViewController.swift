//
//  PhotoGalleryViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/04/22.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Photos
import PhotosUI
import DeviceKit

class PhotoGalleryViewController : BaseViewController, CallPHPickerDelegate, PHPhotoLibraryChangeObserver {
    
    var selectedImage : PHAsset?
    
    //MARK: - ViewModel
    
    private var viewModel = PhotoGalleryViewModel()
    private var selectedPhoto = BehaviorSubject(value: false)
    private lazy var input = PhotoGalleryViewModel.Input(
        selectedPhotoStatus: selectedPhoto.asDriver(onErrorJustReturn: false))
    private lazy var output = viewModel.transform(input: input)
    
    // MARK: - PROPERTIES
    
    private let photoSelectButton = UIButton().then {
        $0.setTitle("선택 완료", for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(.semiBold, size: 16)
        $0.setTitleColor(UIColor.color363636, for: .normal)
        $0.backgroundColor = UIColor.colorF3F3F3
        $0.layer.cornerRadius = 5
    }
    
    private let authorizedPhotoGalleryView = AuthorizedPhotoGalleryView()
    private let deniedPhotoGalleryView = PermissionDeniedView(permissionTitle: "갤러리")
    private let limitedPhotoGalleryView = LimitedPhotoGalleryView()
    
    
    // MARK: - LIFECYCLE
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
            hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuth()
        limitedPhotoGalleryView.delegate = self
        PHPhotoLibrary.shared().register(self)
    }
    override func setupBinding() {
        super.setupBinding()
        
        output.nextButtonStatus.drive(onNext: { [self] value in
            if value {
                photoSelectButton.isEnabled = true
                photoSelectButton.setTitleColor(.color363636, for: .normal)
            }
            else {
                photoSelectButton.isEnabled = false
                photoSelectButton.setTitleColor(.colorCCCCCC, for: .normal)
            }
            
        })
        .disposed(by: disposeBag)
        
        authorizedPhotoGalleryView.photoCollectionView.rx.itemSelected
            .bind { _ in
                if self.authorizedPhotoGalleryView.selectedIndexPath != nil {
                    self.selectedPhoto.onNext(true)
                }
                else {
                    self.selectedPhoto.onNext(false)
                }
            }
            .disposed(by: disposeBag)
        limitedPhotoGalleryView.photoCollectionView.rx.itemSelected
            .bind { _ in
                if self.limitedPhotoGalleryView.selectedIndexPath != nil {
                    self.selectedPhoto.onNext(true)
                }
                else {
                    self.selectedPhoto.onNext(false)
                }
            }
            .disposed(by: disposeBag)
    }
    
    
    override func setupLayout() {
        view.addSubviews(authorizedPhotoGalleryView, limitedPhotoGalleryView, deniedPhotoGalleryView)
    }
    override func setComponents() {
        view.backgroundColor = .colorFFFFFF
        navigationController?.isNavigationBarHidden = false
        let barButton = UIBarButtonItem()
        barButton.customView = photoSelectButton
        navigationItem.rightBarButtonItem = barButton
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        authorizedPhotoGalleryView.isHidden = true
        deniedPhotoGalleryView.isHidden = true
        limitedPhotoGalleryView.isHidden = true
    }
    override func setupConstraints() {
        photoSelectButton.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(80)
        }
        authorizedPhotoGalleryView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        deniedPhotoGalleryView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        limitedPhotoGalleryView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
    private func requestAuth() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
            guard let self = self else { return }
            switch status {
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
                self.requestAuthResponseView(status: status, completion: { _ in
                    DispatchQueue.main.async {
                        self.authorizedPhotoGalleryView.isHidden = true
                        self.limitedPhotoGalleryView.isHidden = true
                        self.deniedPhotoGalleryView.isHidden = false
                    }
                })
            case .authorized:
                print("authorized")
                self.requestAuthResponseView(status: status) { _ in
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.authorizedPhotoGalleryView.isHidden = false
                        self.limitedPhotoGalleryView.isHidden = true
                        self.deniedPhotoGalleryView.isHidden = true
                        self.authorizedPhotoGalleryView.loadPHCachingImage()
                        self.authorizedPhotoGalleryView.photoCollectionView.reloadData()
                    }
                }
            case .limited:
                print("limited")
                self.requestAuthResponseView(status: .limited) { _ in
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.authorizedPhotoGalleryView.isHidden = true
                        self.limitedPhotoGalleryView.isHidden = false
                        self.deniedPhotoGalleryView.isHidden = true
                        PHPhotoLibrary.shared().register(self)
                        self.limitedPhotoGalleryView.photoCollectionView.reloadData()
                    }
                }
                
            @unknown default:
                fatalError()
            }
        }
    }

    func requestAuthResponseView(status : PHAuthorizationStatus, completion : @escaping ((PHAuthorizationStatus) -> Void)) {
        switch status {
        case .notDetermined:
            completion(.notDetermined)
        case .restricted:
            completion(.restricted)
        case .denied:
            completion(.denied)
        case .authorized:
            completion(.authorized)
            print("허용")
        case .limited:
            completion(.limited)
        @unknown default:
            fatalError()
        }
    }
    override func actions() {
        super.actions()
        photoSelectButton.addTarget(self, action: #selector(photoSelectionButtonTapped), for: .touchUpInside)
        deniedPhotoGalleryView.permisstionButton.addTarget(self, action: #selector(permisstionButtonTapped), for: .touchUpInside)
    }
    @objc func permisstionButtonTapped() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)

    }
    @objc func photoSelectionButtonTapped() {
        print("??????")
        if DeviceManager.shared.isHomeButtonDevice() || DeviceManager.shared.isSimulatorIsHomeButtonDevice() {
            ///홈버튼 있는 기종
            let homeButtonPhotoFrameTypeViewController = HomeButtonPhotoFrameTypeViewController()
            let manager = PHImageManager.default()
            let options = PHImageRequestOptions()
            options.deliveryMode = .highQualityFormat
            options.resizeMode = .exact
            selectedImage = authorizedPhotoGalleryView.selectedImage != nil ? authorizedPhotoGalleryView.selectedImage : limitedPhotoGalleryView.selectedImage
            guard let phAsset = selectedImage else { return }
            manager.requestImageDataAndOrientation(
                for: phAsset,
                options: options) { data, _, _, _ in
                    guard let imageData = data, let image = UIImage(data: imageData) else { return }
                    homeButtonPhotoFrameTypeViewController.selectedImage = image
                    self.navigationController?.pushViewController(homeButtonPhotoFrameTypeViewController, animated: true)
                }
        }
        else {
            ///홈버튼 없는 기종
            let homeButtonLessPhotoFrameTypeViewController = HomeButtonLessPhotoFrameTypeViewController()

            let manager = PHImageManager.default()
            let options = PHImageRequestOptions()
            options.deliveryMode = .highQualityFormat
            options.resizeMode = .exact
            selectedImage = authorizedPhotoGalleryView.selectedImage != nil ? authorizedPhotoGalleryView.selectedImage : limitedPhotoGalleryView.selectedImage
            guard let phAsset = selectedImage else { return }
            manager.requestImageDataAndOrientation(
                for: phAsset,
                options: options) { data, _, _, _ in
                    guard let imageData = data, let image = UIImage(data: imageData) else { return }
                    homeButtonLessPhotoFrameTypeViewController.selectedImage = image
                    self.navigationController?.pushViewController(homeButtonLessPhotoFrameTypeViewController, animated: true)
                }
        }
        
    }
    
    // MARK: - PICKER
    func callPicker() {
        PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
    }
    ///변화 감지
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        let fetchOptions = PHFetchOptions()
        limitedPhotoGalleryView.imageFetch = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        DispatchQueue.main.async {
            self.limitedPhotoGalleryView.photoCollectionView.reloadData()
        }

    }
}

