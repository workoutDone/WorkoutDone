//
//  FrameHeaderView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/31.
//

import UIKit

protocol FrameDelegate: AnyObject {
    func didSelectFrame(frameIndex: Int)
}

class FrameHeaderView : UICollectionReusableView {
    let frames : [String] = ["unselectedDefaultImage", "frame1", "frame2", "frame3", "frame4", "frame5", "frame6"]
    var isSelectFrameIndex = 0
    weak var delegate : FrameDelegate?
    
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
        return frames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "frameCategoryCell", for: indexPath) as? FrameCategoryCell else { return UICollectionViewCell() }
        cell.frameImage.image = UIImage(named: frames[indexPath.row])
        
        cell.frameImage.layer.borderWidth = 1
        cell.frameImage.layer.borderColor = UIColor.colorCCCCCC.cgColor
        cell.frameImage.backgroundColor = .colorFFFFFF
        
        if indexPath.row == 0 {
            cell.frameImage.layer.borderWidth = 0
            if isSelectFrameIndex == 0 {
                cell.frameImage.image = UIImage(named: "selectedDefaultImage")
            }
        }
        
        if indexPath.row == isSelectFrameIndex {
            cell.frameImage.layer.borderWidth = 2
            cell.frameImage.layer.borderColor = UIColor.color7442FF.cgColor
            cell.frameImage.backgroundColor = .colorE6E0FF
        }
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isSelectFrameIndex = indexPath.row
        delegate?.didSelectFrame(frameIndex: isSelectFrameIndex)
        collectionView.reloadData()
    }
}
