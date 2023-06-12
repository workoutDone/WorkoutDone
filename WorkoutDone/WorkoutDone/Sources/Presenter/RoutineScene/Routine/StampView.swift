//
//  StampView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/24.
//

import UIKit

protocol StampDelegate : AnyObject {
    func stampTapped(image: String)
}

class StampView: BaseUIView {
    var stampIamges = ["stampAbsImage", "stampArmImage", "stampBackImage", "stampLegImage", "stampRunningImage", "stampVImage"]
    var isSelectStampIndex = -1
    
    weak var delegate: StampDelegate?
    
    private let stampTitleLabel = UILabel().then {
        $0.text = "오운완 도장 선택"
        $0.font = .pretendard(.semiBold, size: 16)
    }
    
    private let stampCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(StampCell.self, forCellWithReuseIdentifier: "stampCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stampCollectionView.delegate = self
        stampCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        [stampTitleLabel, stampCollectionView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        stampTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(42)
        }
        
        stampCollectionView.snp.makeConstraints {
            $0.top.equalTo(stampTitleLabel.snp.bottom).offset(11)
            $0.height.equalTo(46)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension StampView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stampIamges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stampCell", for: indexPath) as? StampCell else { return UICollectionViewCell() }
        cell.stampImage.image = UIImage(named: stampIamges[indexPath.row])
        
        cell.contentView.layer.cornerRadius = cell.frame.height / 2
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        
        if isSelectStampIndex == indexPath.row {
            cell.contentView.layer.borderColor = UIColor.color7442FF.cgColor
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 39, bottom: 0, right: 39)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 46, height: 46)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == isSelectStampIndex {
            isSelectStampIndex = -1
        } else {
            isSelectStampIndex = indexPath.row
        }
        
        collectionView.reloadData()
        
        delegate?.stampTapped(image: stampIamges[indexPath.row])
    }
}
