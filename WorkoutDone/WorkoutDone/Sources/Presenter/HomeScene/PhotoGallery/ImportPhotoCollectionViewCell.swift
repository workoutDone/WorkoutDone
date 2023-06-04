//
//  ImportPhotoCollectionViewCell.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/30.
//

import UIKit
import SnapKit
import Then

protocol ImportedPhotosDelegate : AnyObject {
    func importPhotoButton()
}

class ImportPhotoCollectionViewCell : UICollectionViewCell {
//    var handler: (() -> (Void))?
    var delegate : ImportedPhotosDelegate?
    let importPhotoButton = UIButton().then {
        $0.setImage(UIImage(named: "importPhotoImage"), for: .normal)
        $0.layer.backgroundColor = UIColor.colorFFFFFF.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.color7442FF.cgColor
    }
    override init(frame: CGRect) {
           super.init(frame: frame)
        setStyle()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(importPhotoButton)
        setLayout()
    }
    private func setLayout() {
        importPhotoButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    private func setStyle() {
        importPhotoButton.addTarget(self, action: #selector(importPhotoButtonTapped), for: .touchUpInside)
    }
    @objc func importPhotoButtonTapped() {
//        handler?()
        delegate?.importPhotoButton()
    }
}
