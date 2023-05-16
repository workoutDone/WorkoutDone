//
//  AuthorizedPhotoCollectionView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/04/22.
//

import UIKit
import SnapKit
import Then
import Photos
import Kingfisher

class AuthorizedPhotoGalleryView : BaseUIView {
    private let imageManager:PHCachingImageManager = PHCachingImageManager()
    private var imageFetch: PHFetchResult<PHAsset>?
    
    
    var selectedIndexPath : IndexPath?
    var selectedImage : PHAsset?
    private var images = [PHAsset]()
    let photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDelegateDataSource()
        loadPHCachingImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func loadPHCachingImage() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        self.imageFetch = PHAsset.fetchAssets(with: .image, options: fetchOptions)
    }
    
    override func setupLayout() {
        super.setupLayout()
        self.addSubview(photoCollectionView)
    }
    override func setupConstraints() {
        super.setupConstraints()
        photoCollectionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(15)
        }
    }
    private func setDelegateDataSource() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }
}

extension AuthorizedPhotoGalleryView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImage = imageFetch?[indexPath.item]
        
        if selectedIndexPath == indexPath {
            collectionView.deselectItem(at: indexPath, animated: true)
            selectedIndexPath = nil
        }
        else {
            selectedIndexPath = indexPath
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageFetch?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else { fatalError("not found") }
        
        let frameSize = (collectionView.frame.width)
        let size = CGSize(width: frameSize, height: frameSize)
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .exact
        if let asset : PHAsset = self.imageFetch?.object(at: indexPath.row) {
            self.imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: nil) { (image, error) in
                cell.photoImageView.image = image
            }
        }
        return cell
//        let manager = PHImageManager.default()
//        manager.requestImageDataAndOrientation(
//            for: asset,
//            options: options) { data, _, _, _ in
//                DispatchQueue.main.async {
//                    guard let imageData = data, let image = UIImage(data: imageData) else { return }
//                    cell.photoImageView.image = image
//                }
//            }
    }
    ///옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    ///위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameSize = (collectionView.frame.width - 12) / 3
        let size = CGSize(width: frameSize, height: frameSize)
        return size
    }
    
    
}
