//
//  GalleryViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/24.
//

import UIKit
import SnapKit
import Then

class GalleryViewController : BaseViewController {
    var galleryViewModel = GalleryViewModel()
    var monthImages = [String : [UIImage]]()
    var month = [String]()
    var frameImages = [UIImage]()
    var sortFrame : Bool = false
    
    private let imageCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 00, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MonthHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "monthHeaderView")
        collectionView.register(FrameHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "frameHeaderView")
        collectionView.register(SortButtonCell.self, forCellWithReuseIdentifier: "sortButtonCell")
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "imageCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    override func setupLayout() {
        super.setupLayout()
        
        self.view.addSubview(imageCollectionView)
    }
    
    override func setComponents() {
        super.setComponents()
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        monthImages = galleryViewModel.loadImagesForMonth()
        month = monthImages.keys.sorted(by: >)
        
        frameImages = galleryViewModel.loadImagesForFrame(frameIndex: 0)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        imageCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func getScreenPositionForCell(collectionView: UICollectionView, cell: UICollectionViewCell) -> CGRect? {
        if let indexPath = collectionView.indexPath(for: cell) {
            let cellRect = collectionView.layoutAttributesForItem(at: indexPath)?.frame
            let cellRectInSuperview = collectionView.convert(cellRect ?? CGRect.zero, to: collectionView.superview)
            return cellRectInSuperview
        }
        return nil
    }
}

extension GalleryViewController : SortButtonTappedDelegate, FrameDelegate {
    func sortButtonTapped(sortDelegate: Bool) {
        sortFrame = sortDelegate
       
        imageCollectionView.reloadData()
    }
    
    func didSelectFrame(frameIndex: Int) {
        frameImages = galleryViewModel.loadImagesForFrame(frameIndex: frameIndex)
        imageCollectionView.reloadData()
    }
}


extension GalleryViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if !sortFrame {
            return monthImages.count + 1
        }
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if !sortFrame {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "monthHeaderView", for: indexPath) as? MonthHeaderView else { return MonthHeaderView()
            }
            if indexPath.section > 0 {
                header.monthLabel.text = "\(month[indexPath.section - 1])월"
            }
            
            return header
        }
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "frameHeaderView", for: indexPath) as? FrameHeaderView else { return FrameHeaderView()
        }
        header.delegate = self
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: 0, height: 0)
        }
        if !sortFrame {
            return CGSize(width: view.frame.size.width, height: 18)
        }
        return CGSize(width: view.frame.size.width, height: 99)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
       
        if !sortFrame {
            return monthImages[month[section-1]]?.count ?? 0
        }
        
        return frameImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sortButtonCell", for: indexPath) as? SortButtonCell else { return UICollectionViewCell() }
            cell.delegate = self
            
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell else { return UICollectionViewCell() }
        if !sortFrame {
            cell.image.image = monthImages[month[indexPath.section-1]]?[indexPath.row]
        } else {
            cell.image.image = frameImages[indexPath.row]
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 19, left: 15, bottom: 11, right: 15)
        }
        if !sortFrame {
            return UIEdgeInsets(top: 14, left: 15, bottom: 34, right: 15)
        }
        
        return UIEdgeInsets(top: 30, left: 15, bottom: 40, right: 15)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCell else { return }
        let positionOfCell = getScreenPositionForCell(collectionView: collectionView, cell: cell)
        
        let galleryDetailVC = GalleryDetailViewController()
        galleryDetailVC.frameX = positionOfCell?.minX ?? 0
        galleryDetailVC.frameY = positionOfCell?.minY ?? 0
        galleryDetailVC.size = positionOfCell?.width ?? 0
        galleryDetailVC.image.image = sortFrame ? frameImages[indexPath.row] : monthImages[month[indexPath.section-1]]?[indexPath.row]
        galleryDetailVC.modalPresentationStyle = .overFullScreen
        self.present(galleryDetailVC, animated: false)
        
    }
}
