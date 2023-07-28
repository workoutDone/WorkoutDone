//
//  HomeButtonLessPressShutterViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/23.
//

import UIKit
import SnapKit
import Then
import Photos
import RxSwift
import RxCocoa

final class HomeButtonLessPressShutterViewController : BaseViewController {
    
    var isSelectFrame: Int = 0
    var captureImage: UIImage?
    let albumName: String = "오운완"
    var album: PHAssetCollection?
    
    private var viewModel = HomeButtonLessPressShutterViewModel()
    private var selectedData = PublishSubject<Int>()
    private var selectedFrameType = PublishSubject<Int>()
    private var capturedImage = PublishSubject<UIImage>()
    private var saveDataTrigger = PublishSubject<Void>()
    private lazy var input = HomeButtonLessPressShutterViewModel.Input(
        selectedData: selectedData.asDriver(onErrorJustReturn: 0),
        selectedFrameType: selectedFrameType.asDriver(onErrorJustReturn: 0),
        capturedImage: capturedImage.asDriver(onErrorJustReturn: UIImage()),
        saveButtonTapped: saveDataTrigger.asDriver(onErrorJustReturn: ()))
    private lazy var output = viewModel.transform(input: input)
    
    
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
        $0.text = "스토리 업로드"
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
    
    override func setupBinding() {
        output.saveData.drive(onNext: {
            self.requestAuth()
            print("??????")
        })
        .disposed(by: disposeBag)
        
        saveButton.rx.tap
            .bind { value in
                self.saveDataTrigger.onNext(())
            }
            .disposed(by: disposeBag)
        
        guard let image = captureImage else { return }
        let resizedImage = resizeImage(image: image, newSize: CGSize(width: view.frame.width, height: view.frame.width * (4 / 3)))
        capturedImage.onNext(resizedImage)
        guard let homeVC = self.navigationController?.viewControllers.first as? HomeViewController else { return }
        let homeVCDate = homeVC.calendarView.selectDate ?? Date()
        selectedData.onNext(homeVCDate.dateToInt())
        selectedFrameType.onNext(isSelectFrame)
    }
    
    
    override func setComponents() {
        view.backgroundColor = .colorFFFFFF
        captureImageView.image = self.captureImage
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
        instaButton.addTarget(self, action: #selector(instaButtonTapped), for: .touchUpInside)
        againButton.addTarget(self, action: #selector(againButtonTapped), for: .touchUpInside)
    }
    @objc func instaButtonTapped() {
        if let storyShareURL = URL(string: "instagram-stories://share?source_application=\(Config.facebookKey)") {
            if UIApplication.shared.canOpenURL(storyShareURL) {
                let targetSize = CGSize(width: captureImageView.frame.width, height: captureImageView.frame.height)
                let renderer = UIGraphicsImageRenderer(size: targetSize)

                let renderImage = renderer.image { _ in
                    captureImageView.drawHierarchy(in: (captureImageView.bounds), afterScreenUpdates: true)
                }
                guard let imageData = renderImage.pngData() else { return }
                let pasteboardItems : [String:Any] = [
                          "com.instagram.sharedSticker.backgroundImage": imageData,
                          "com.instagram.sharedSticker.backgroundTopColor" : "#636e72",
                          "com.instagram.sharedSticker.backgroundBottomColor" : "#b2bec3",
                      ]
                let pasteboardOptions = [
                     UIPasteboard.OptionsKey.expirationDate : Date().addingTimeInterval(300)
                 ]
                 
                 UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
                 
                 
                 UIApplication.shared.open(storyShareURL, options: [:], completionHandler: nil)
            }
            else {
                
                            let alert = UIAlertController(title: "알림", message: "인스타그램이 필요합니다", preferredStyle: .alert)
                            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                            alert.addAction(ok)
                            self.present(alert, animated: true, completion: nil)
            }
        }
    }
    @objc func againButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    private func requestAuth() {
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { [weak self] status in
            guard let self = self else { return }
            switch status {
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
                self.requestAuthResponseView(status: status) { _ in
                    DispatchQueue.main.async {
                        self.showToastMessage(message: "사진이 저장되었습니다.")
                    }
                }
            case .authorized:
                print("authorized")
                self.requestAuthResponseView(status: status) { _ in
                    self.checkAlbumExistence()
                    DispatchQueue.main.async {
                        self.showToastMessage(message: "갤러리에 저장되었습니다")
                    }
                }
            case .limited:
                print("limited")
                self.requestAuthResponseView(status: status) { _ in
                    DispatchQueue.main.async {
                        self.showToastMessage(message: "사진이 저장되었습니다.")
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
    
    
    private func showToastMessage(message : String) {
        let saveImageToastMessageVC = SaveImageToastMessageViewController()
        saveImageToastMessageVC.toastMesssageLabel.text = message
        saveImageToastMessageVC.modalPresentationStyle = .overFullScreen
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.present(saveImageToastMessageVC, animated: false)
        }) { (completed) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut) {
                saveImageToastMessageVC.dismiss(animated: false)
                }
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
// MARK: - EXTENSIONs
extension HomeButtonLessPressShutterViewController {
    private func checkAlbumExistence() {
        let fetchOptions = PHFetchOptions() // 사진 검색을 위한 클래스
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName) // 검색 결과에 적용할 필터링 조건 설정
        let collections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions) // 조건에 따라 앨범 검색
        // 검색된 앨범이 있는 경우,
        if let collection = collections.firstObject {
            // 포토 라이브러리에 추가, 수정, 삭제 등의 변경 사항을 적용하기 위해 사용, 변경 사항은 백그라운드에서 비동기적으로 처리
            PHPhotoLibrary.shared().performChanges({
                let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: self.captureImage!) // PHAsset을 생성하고 고유 식별자를 가져옴
                let assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset // 실제 이미지가 생성되기 전에 플레이스홀더 반환. PHAsset의 삭별자를 가지고 있으며 참조를 유지하거나 앨범에 이미즈를 추가하는 작업을 할 수 있음
                let albumChangeRequest = PHAssetCollectionChangeRequest(for: collection) // 앨범에 대한 변경 작업 처리
                albumChangeRequest?.addAssets([assetPlaceholder!] as NSArray) // 앨범에 이미지 추가
                albumChangeRequest?.insertAssets([assetPlaceholder!] as NSArray, at: IndexSet(integer: 0))
            }, completionHandler: { (success, error) in
                if success {
                    print("이미지 추가")
                } else {
                    print("이미지 추가 실패 : \(error?.localizedDescription ?? "")")
                }
            })
        } else {
            self.saveImageToGallery()
        }
    }
    
    private func saveImageToGallery() {
        // 폴더 생성
        var albumPlaceholder: PHObjectPlaceholder?
        PHPhotoLibrary.shared().performChanges({
            let albumCreationRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: self.albumName)
            albumPlaceholder = albumCreationRequest.placeholderForCreatedAssetCollection
        }, completionHandler: { (success, error) in
            if success, let albumPlaceholder = albumPlaceholder {
                print("앨범 생성")
                // 이미지 저장
                PHPhotoLibrary.shared().performChanges({
                    let album = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [albumPlaceholder.localIdentifier], options: nil)
                    if let album = album.firstObject {
                        let albumChangeRequest = PHAssetCollectionChangeRequest(for: album)
                        let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: self.captureImage!)
                        let assetPlaceholder = creationRequest.placeholderForCreatedAsset
                        let albumAssets: Void? = albumChangeRequest?.addAssets([assetPlaceholder!] as NSArray)
                        if albumAssets != nil {
                            print("이미지 저장")
                        }
                    }
                }, completionHandler: { (success, error) in
                    if !success {
                        print("이미지 저장 실패: \(error?.localizedDescription ?? "")")
                    }
                })
            }
        })
    }
}

