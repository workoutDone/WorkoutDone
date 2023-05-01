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

class PhotoGalleryViewController : BaseViewController {
    
    //MARK: - ViewModel
    
    private var viewModel = PhotoGalleryViewModel()
    private var didLoad = PublishSubject<Void>()
    private lazy var input = PhotoGalleryViewModel.Input(loadView: didLoad.asDriver(onErrorJustReturn: ()))
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

    }
    override func setupBinding() {
        super.setupBinding()
        
        output.photoAuthority.drive(onNext: { value in
            switch value {
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            case .authorized:
                print("authorized")
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                assets.enumerateObjects { (object, count, stop) in
                    self.authorizedPhotoGalleryView.images.append(object)
                }
                self.authorizedPhotoGalleryView.images.reverse()
                DispatchQueue.main.async {
                    self.authorizedPhotoGalleryView.photoCollectionView.reloadData()
                }
            case .limited:
                print("limited")
            }
        })
        .disposed(by: disposeBag)
        
        
        didLoad.onNext(())
    }
    
    
    override func setupLayout() {
        view.addSubviews(authorizedPhotoGalleryView)
    }
    override func setComponents() {
        view.backgroundColor = .colorFFFFFF
        navigationController?.isNavigationBarHidden = false
        let barButton = UIBarButtonItem()
        barButton.customView = photoSelectButton
        navigationItem.rightBarButtonItem = barButton
    }
    override func setupConstraints() {
        photoSelectButton.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(80)
        }
        authorizedPhotoGalleryView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
    }
    override func actions() {
        super.actions()
        photoSelectButton.addTarget(self, action: #selector(photoSelectionButtonTapped), for: .touchUpInside)
    }
    @objc func photoSelectionButtonTapped() {
        if DeviceManager.shared.isHomeButtonDevice() || DeviceManager.shared.isSimulatorIsHomeButtonDevice() {
            ///홈버튼 있는 기종
            let homeButtonPhotoFrameTypeViewController = HomeButtonPhotoFrameTypeViewController()
            navigationController?.pushViewController(homeButtonPhotoFrameTypeViewController, animated: true)
        }
        else {
            ///홈버튼 없는 기종
            let homeButtonLessPhotoFrameTypeViewController = HomeButtonLessPhotoFrameTypeViewController()
            navigationController?.pushViewController(homeButtonLessPhotoFrameTypeViewController, animated: true)
        }
        
    }
    
    // MARK: - ACTIONS
}
// MARK: - EXTENSIONs
private extension PhotoGalleryViewController {
    
}

