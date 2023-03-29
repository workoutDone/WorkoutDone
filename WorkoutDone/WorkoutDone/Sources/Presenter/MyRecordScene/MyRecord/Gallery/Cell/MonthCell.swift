//
//  MonthCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/28.
//

import UIKit
import SnapKit
import Then

class MonthCell : UICollectionViewCell {
    let monthLabel = UILabel().then {
        $0.text = "10월"
        $0.font = .pretendard(.semiBold, size: 18)
    }
    
    let monthImageCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MonthImageCell.self, forCellWithReuseIdentifier: "monthImageCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .orange
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupConstraints()
        
        monthImageCollectionView.delegate = self
        monthImageCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ACTIONS
    func setupLayout() {
        contentView.addSubview(monthLabel)
        contentView.addSubview(monthImageCollectionView)
    }
    
    func setupConstraints() {
        monthLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
        
        monthImageCollectionView.snp.makeConstraints {
            $0.top.equalTo(monthLabel.snp.bottom).offset(14)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension MonthCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "monthImageCell", for: indexPath) as? MonthImageCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 3 - 6 , height: collectionView.bounds.width / 3 - 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}

