//
//  SortByFrameView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/27.
//

import UIKit
import SnapKit
import Then

class SortByFrameView : BaseUIView {
    let frameCategoryImages: [String] = ["frame1", "frame2", "frame3", "frame4", "frame5", "frame6"]
    
    private let frameCategoryCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FrameCell.self, forCellWithReuseIdentifier: "frameCategoryCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private let frameImageCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "frameImageCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        
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
        
        self.addSubview(frameCategoryCollectionView)
        self.addSubview(frameImageCollectionView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        frameCategoryCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(99)
        }
        
        frameImageCollectionView.snp.makeConstraints {
            $0.top.equalTo(frameCategoryCollectionView.snp.bottom).offset(40)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo((5 * 116) + (4 * 6))
        }
    }
    
    func setDelegateDataSource() {
        frameCategoryCollectionView.delegate = self
        frameCategoryCollectionView.dataSource = self
        
        frameImageCollectionView.delegate = self
        frameImageCollectionView.dataSource = self
    }
}

extension SortByFrameView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == frameCategoryCollectionView {
            return frameCategoryImages.count + 1
        }
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == frameCategoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "frameCategoryCell", for: indexPath) as? FrameCell else { return UICollectionViewCell() }
            if indexPath.row == 0 {
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            } else {
                cell.frameImage.image = UIImage(named: frameCategoryImages[indexPath.row - 1])
            }
            cell.isSelected = indexPath.row == 0
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "frameImageCell", for: indexPath) as? ImageCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == frameCategoryCollectionView {
            return CGSize(width: collectionView.bounds.height , height: collectionView.bounds.height)
        }
        return CGSize(width: 116 , height: 116)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == frameCategoryCollectionView {
            return 8
        }
        return 6
    }
}
