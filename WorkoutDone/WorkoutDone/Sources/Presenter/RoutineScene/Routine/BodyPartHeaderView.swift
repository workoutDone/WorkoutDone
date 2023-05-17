//
//  BodyPartHeaderView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/17.
//

import UIKit
import SnapKit
import Then

class BodyPartHeaderView: UICollectionReusableView {
    let bodyParts = ["가슴", "등", "하체", "어깨", "삼두", "이두", "냠냠", "졸려", "하암"]
    var isSelectBodyPartIndex = 0
    
    private let bodyPartCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BodyPartCell.self, forCellWithReuseIdentifier: "bodyPartCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .colorF8F6FF
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bodyPartCollectionView.delegate = self
        bodyPartCollectionView.dataSource = self
        
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        self.addSubview(bodyPartCollectionView)
    }
    
    func setupConstraints() {
        bodyPartCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension BodyPartHeaderView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bodyParts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bodyPartCell", for: indexPath) as? BodyPartCell else { return UICollectionViewCell() }
        cell.layer.cornerRadius = 31 / 2
        cell.backgroundColor = .clear
        cell.bodyPartLabel.textColor = .colorC8B4FF
        cell.bodyPartLabel.font = .pretendard(.regular, size: 16)
        
        if isSelectBodyPartIndex == indexPath.row {
            cell.backgroundColor = .colorE6E0FF
            cell.bodyPartLabel.textColor = .color7442FF
            cell.bodyPartLabel.font = .pretendard(.semiBold, size: 16)
            //cell.layer.cornerRadius = 31 / 2
        }
        cell.bodyPartLabel.text = bodyParts[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8.5, left: 19, bottom: 10.5, right: 19)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 52, height: 31)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isSelectBodyPartIndex = indexPath.row
        collectionView.reloadData()
    }
}
