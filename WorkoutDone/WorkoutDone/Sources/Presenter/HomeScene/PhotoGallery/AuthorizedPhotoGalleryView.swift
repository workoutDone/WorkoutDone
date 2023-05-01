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

class AuthorizedPhotoGalleryView : BaseUIView {
    var images = [PHAsset]()
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setupLayout() {
        super.setupLayout()
        self.addSubview(photoCollectionView)
    }
    override func setupConstraints() {
        super.setupConstraints()
        photoCollectionView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    func setDelegateDataSource() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }
}

extension AuthorizedPhotoGalleryView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else { fatalError("not found") }
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        let frameSize = (collectionView.frame.width - 8) / 3
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        manager.requestImage(for: asset, targetSize: CGSize(width: frameSize, height: frameSize), contentMode: .aspectFit, options: options) { image, _ in
            DispatchQueue.main.async {
                cell.photoImageView.image = image
            }
        }
        return cell
    }
    ///옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    ///위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameSize = (collectionView.frame.width - 16) / 3
        let size = CGSize(width: frameSize, height: frameSize)
        return size
    }
    
    
}
