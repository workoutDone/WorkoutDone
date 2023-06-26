//
//  PressShutterViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/04/06.
//

import UIKit
import Photos

class PressShutterViewController: BaseViewController {
    let frameImageViewModel = FrameImageViewModel()
    
    var isSelectFrame: Int = 0
    var captureImage: UIImage?
    let albumName: String = "오운완"
    
    var album: PHAssetCollection?
    var captureImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let againButton = UIButton().then {
        $0.backgroundColor = .colorE6E0FF
        $0.layer.cornerRadius = 31
    }
    
    private let againImage = UIImageView().then {
        $0.image = UIImage(named: "again")
    }
    
    private let againLabel = UILabel().then {
        $0.text = "다시 찍기"
        $0.font = .pretendard(.medium, size: 14)
    }
    
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
    }
    
    private let instaButton = UIButton().then {
        $0.backgroundColor = .colorE6E0FF
        $0.layer.cornerRadius = 31
    }

    private let instaImage = UIImageView().then {
        $0.image = UIImage(named: "insta")
    }
    
    private let instaLabel = UILabel().then {
        $0.text = "인스타 업로드"
        $0.font = .pretendard(.medium, size: 14)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setComponents() {
        view.backgroundColor = .colorFFFFFF
    }
    
    override func setupLayout() {
        
        captureImageView = UIImageView(image: self.captureImage)
        
        [captureImageView, againButton, againLabel, saveButton, saveLabel, instaButton, instaLabel].forEach {
            view.addSubview($0)
        }
        
        againButton.addSubview(againImage)
        saveButton.addSubview(saveImage)
        instaButton.addSubview(instaImage)
    }
    
    override func setupConstraints() {
        captureImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view.frame.width * (4 / 3))
        }
        
        againButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-63)
            $0.leading.equalToSuperview().offset(32)
            $0.width.height.equalTo(62)
        }

        againImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(31)
        }
        
        againLabel.snp.makeConstraints {
            $0.centerX.equalTo(againButton)
            $0.top.equalTo(againButton.snp.bottom).offset(10)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(againButton)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(62)
        }
        
        saveImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(41)
        }
        
        saveLabel.snp.makeConstraints {
            $0.centerX.equalTo(saveButton)
            $0.top.equalTo(saveButton.snp.bottom).offset(10)
        }
        
        instaButton.snp.makeConstraints {
            $0.top.equalTo(againButton)
            $0.trailing.equalToSuperview().offset(-32)
            $0.width.height.equalTo(62)
        }

        instaImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(34)
        }
        
        instaLabel.snp.makeConstraints {
            $0.centerX.equalTo(instaButton)
            $0.top.equalTo(instaButton.snp.bottom).offset(10)
        }
    }
    
    override func actions() {
        againButton.addTarget(self, action: #selector(againButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        instaButton.addTarget(self, action: #selector(instaButtonTapped), for: .touchUpInside)
    }
    @objc func againButtonTapped(sender: UIButton!) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func saveButtonTapped(sender: UIButton!) {
        showToastMessage()
        getGalleryAuthorization()
        
        let resizedImage = resizeImage(image: captureImage!, newSize: CGSize(width: view.frame.width, height: view.frame.width * (4 / 3)))
        
        if let homeVC = self.navigationController?.viewControllers.first as? HomeViewController {

            frameImageViewModel.saveImageToRealm(date: homeVC.calendarView.selectDate ?? Date(), frameType: isSelectFrame, image: resizedImage)
        }
    }
    
    func showToastMessage() {
        let saveImageToastMessageVC = SaveImageToastMessageViewController()
        saveImageToastMessageVC.modalPresentationStyle = .overFullScreen
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.present(saveImageToastMessageVC, animated: false)
        }) { (completed) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut) {
                saveImageToastMessageVC.dismiss(animated: false)
                }
                self.navigationController?.popToRootViewController(animated: true)
                
//                if let homeVC = self.navigationController?.viewControllers.first as? HomeViewController {
//                    homeVC.setWorkOutDoneImage()
//                }
            }
        }
    }
    
    @objc func instaButtonTapped(sender: UIButton!) {
        print("^-^")
    }
    
    func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func getGalleryAuthorization() {
        // 접근 권한 요청
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                self.checkAlbumExistence()
            case .denied:
                print("갤러리 접근 권한이 거부되었습니다.")
            case .restricted:
                print("갤러리 접근이 제한되었습니다.")
            case .notDetermined:
                print("갤러리 접근 권한이 아직 결정되지 않았습니다.")
            default:
                fatalError("갤러리 접근 권한 상태를 처리할 수 없습니다.")
            }
        }
    }
    
    func checkAlbumExistence() {
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
    
    func saveImageToGallery() {
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
