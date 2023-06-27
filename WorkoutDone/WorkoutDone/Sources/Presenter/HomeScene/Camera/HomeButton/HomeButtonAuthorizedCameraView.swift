//
//  HomeButtonAuthorizedCameraView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/06/22.
//

import UIKit

final class HomeButtonAuthorizedCameraView : BaseUIView {
    private let frameImages: [String] = ["unselectedDefaultImage", "frame1", "frame2", "frame3", "frame4", "frame5", "frame6"]
    var isSelectFrameImagesIndex = 0
    // MARK: - PROPERTIES
    lazy var previewView = PreviewView()
    
    private let frameImageView = UIImageView()
    
    let gridImageView = UIImageView().then {
        $0.image = UIImage(named: "cameraFrameImage")
    }
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FrameCell.self, forCellWithReuseIdentifier: "FrameCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    let shutterButton = UIButton().then {
        $0.setImage(UIImage(named: "shutter"), for: .normal)
    }
    
    let switchCameraButton = UIButton().then {
        $0.setImage(UIImage(named: "switchCamera"), for: .normal)
    }
    private let captureBackView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDelegateDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUI() {
        super.setUI()
        gridImageView.isHidden = true
    }
    
    override func setupLayout() {
        super.setupLayout()
        self.addSubviews(previewView, collectionView, captureBackView)
        previewView.addSubviews(gridImageView, frameImageView)
        captureBackView.addSubviews(shutterButton, switchCameraButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        previewView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
//            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.size.width * 4 / 3)
        }
        gridImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        frameImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(previewView.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(66)
        }
        captureBackView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        shutterButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        switchCameraButton.snp.makeConstraints {
            $0.width.height.equalTo(42)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(23)
        }
    }
    private func setDelegateDataSource() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension HomeButtonAuthorizedCameraView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frameImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrameCell", for: indexPath) as? FrameCell else { return UICollectionViewCell() }
        cell.frameImage.image = UIImage(named: frameImages[indexPath.row])
  
        cell.frameImage.layer.borderWidth = 1
        cell.frameImage.layer.borderColor = UIColor.colorCCCCCC.cgColor
        cell.frameImage.backgroundColor = .colorFFFFFF
        
        if indexPath.row == 0 {
            cell.frameImage.layer.borderWidth = 0
            if isSelectFrameImagesIndex == 0 {
                cell.frameImage.image = UIImage(named: "selectedDefaultImage")
            }
        }
        
        if indexPath.row == isSelectFrameImagesIndex {
            cell.frameImage.layer.borderWidth = 2
            cell.frameImage.layer.borderColor = UIColor.color7442FF.cgColor
            cell.frameImage.backgroundColor = .colorE6E0FF
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 66 , height: 66)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isSelectFrameImagesIndex = indexPath.row
        if indexPath.row == 0 {
            frameImageView.image = nil
        } else {
            frameImageView.image = UIImage(named: "cameraFrame\(indexPath.row)")
        }
        collectionView.reloadData()
    }
}
