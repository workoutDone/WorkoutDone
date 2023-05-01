//
//  PhotoCollectionViewCell.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/04/22.
//

import UIKit
import SnapKit
import Then

class PhotosCollectionViewCell : UICollectionViewCell {
    let photoImageView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.contentMode = .scaleToFill
        $0.layer.masksToBounds = true
    }
    let selectedButtonImage = UIImageView()
    let selectedEffectView = UIView()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                photoImageView.layer.borderWidth = 1
                photoImageView.layer.cornerRadius = 5
                photoImageView.layer.borderColor = UIColor.color7442FF.cgColor
                selectedEffectView.backgroundColor = UIColor(hex: 0x000000, alpha: 0.2)
                selectedButtonImage.image = UIImage(named: "selectedPhoto")
                
            }
            else {
                photoImageView.layer.borderWidth = 0
                selectedButtonImage.image = UIImage(named: "notSelectedPhoto")
                selectedEffectView.backgroundColor = .clear
                photoImageView.layer.borderColor = .none
            }
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubviews(photoImageView, selectedEffectView, selectedButtonImage)
        setLayout()
    }
    
    func setLayout() {
        photoImageView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        selectedEffectView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        selectedButtonImage.snp.makeConstraints {
            $0.top.equalTo(photoImageView.snp.top).offset(7)
            $0.trailing.equalTo(photoImageView.snp.trailing).offset(-7)
        }
    }

}
