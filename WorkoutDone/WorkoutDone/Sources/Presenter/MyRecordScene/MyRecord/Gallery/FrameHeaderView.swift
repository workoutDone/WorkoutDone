//
//  FrameHeaderView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/31.
//

import UIKit

class FrameHeaderView : UICollectionReusableView {
    let frameImages: [String] = ["frame1", "frame2", "frame3", "frame4", "frame5", "frame6"]
    
    private let frameCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FrameCategoryCell.self, forCellWithReuseIdentifier: "frameCategoryCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
        setupConstraints()
        
        frameCollectionView.delegate = self
        frameCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(frameCollectionView)
    }
    
    func setupConstraints() {
        frameCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

extension FrameHeaderView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frameImages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "frameCategoryCell", for: indexPath) as? FrameCategoryCell else { return UICollectionViewCell() }
        if indexPath.row == 0 {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        } else {
            cell.frameImage.image = UIImage(named: frameImages[indexPath.row - 1])
        }
        cell.isSelected = indexPath.row == 0
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 99, height: 99)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
