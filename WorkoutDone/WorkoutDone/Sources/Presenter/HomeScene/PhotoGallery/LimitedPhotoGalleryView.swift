//
//  LimitedPhotoGalleryView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/16.
//

import UIKit

protocol CallPHPickerDelegate : AnyObject {
    func callPicker()
}

class LimitedPhotoGalleryView : BaseUIView, ImportedPhotosDelegate {
    var delegate : CallPHPickerDelegate?
    let photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImportPhotoCollectionViewCell.self, forCellWithReuseIdentifier: "ImportPhotoCollectionViewCell")
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
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(15)
        }
    }
    private func setDelegateDataSource() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }
    func importPhotoButton() {
        print("ㅎㅇ")
        delegate?.callPicker()
    }
}
extension LimitedPhotoGalleryView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImportPhotoCollectionViewCell", for: indexPath) as? ImportPhotoCollectionViewCell else { fatalError() }
            cell.delegate = self
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else { fatalError() }
            return cell
        }
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
