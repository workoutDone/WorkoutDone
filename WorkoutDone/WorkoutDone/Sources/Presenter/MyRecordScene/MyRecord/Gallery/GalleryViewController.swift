//
//  GalleryViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/24.
//

import UIKit
import SnapKit
import Then

struct MonthImages {
    var month : Int
    var image : [String]
}

class GalleryViewController : BaseViewController {
    let MonthImagesSampleData = [MonthImages(month: 3, image: Array(repeating: "", count: 9)), MonthImages(month: 2, image: Array(repeating: "", count: 11)), MonthImages(month: 1, image: Array(repeating: "", count: 12))]
    
    private let monthCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 00, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MonthHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "monthHeaderView")
        collectionView.register(SortButtonCell.self, forCellWithReuseIdentifier: "sortButtonCell")
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "imageCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .orange
        
        return collectionView
    }()
    
    override func setupLayout() {
        super.setupLayout()
        
        self.view.addSubview(monthCollectionView)
    }
    
    override func setComponents() {
        super.setComponents()
        
        monthCollectionView.delegate = self
        monthCollectionView.dataSource = self
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        monthCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
   
}

extension GalleryViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MonthImagesSampleData.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "monthHeaderView", for: indexPath) as? MonthHeaderView else { return MonthHeaderView()
        }
        header.monthLabel.text = "\(MonthImagesSampleData[indexPath.section - 1].month)월"
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: 0, height: 0)
        }
        return CGSize(width: view.frame.size.width, height: 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return MonthImagesSampleData[section - 1].image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sortButtonCell", for: indexPath) as? SortButtonCell else { return UICollectionViewCell() }
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 19, left: 15, bottom: 11, right: 15)
        }
        return UIEdgeInsets(top: 14, left: 15, bottom: 34, right: 15)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width - 30, height: 30)
        }
        let width : CGFloat = (view.frame.width - 42) / 3
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }

}

