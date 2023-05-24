//
//  StampView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/24.
//

import UIKit

class StampView: BaseUIView {
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
            $0.top.equalTo(stampTitleLabel.snp.bottom).offset(14)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension StampView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stampCell", for: indexPath) as? StampCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 42, bottom: 0, right: 42)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }
}
