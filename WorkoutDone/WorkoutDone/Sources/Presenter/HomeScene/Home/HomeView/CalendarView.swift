//
//  CalendarView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/05.
//

import UIKit
import SnapKit
import Then

class CalendarView: BaseUIView {
    // MARK: - PROPERTIES
    var currentMonth: Int = 3
    
    private lazy var currentMonthLabel = UILabel().then {
        $0.textColor = .colorECE5FF
        $0.font = .pretendard(.bold, size: 14)
        $0.text = "\(currentMonth)월"
    }
    
    private let previousMonthButton = UIButton().then {
        $0.setImage(UIImage(named: "previousMonth"), for: .normal)
    }
    
    private let nextMonthButton = UIButton().then {
        $0.setImage(UIImage(named: "nextMonth"), for: .normal)
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "CalendarCell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .color7442FF
        
        return collectionView
    }()
    
    private let showOrHideDateButton = UIButton().then {
        $0.setImage(UIImage(named: "hide"), for: .normal)
    }
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(previousMonthButton)
        self.addSubview(currentMonthLabel)
        self.addSubview(nextMonthButton)
        self.addSubview(collectionView)
        self.addSubview(showOrHideDateButton)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        setLayout()
        
        setAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ACTIONS
    func setLayout() {
        previousMonthButton.snp.makeConstraints {
            $0.trailing.equalTo(currentMonthLabel.snp.leading).offset(-33)
            $0.centerY.equalTo(currentMonthLabel)
            $0.width.equalTo(7.28)
            $0.height.equalTo(13)
        }
        
        currentMonthLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(50)
        }
        
        nextMonthButton.snp.makeConstraints {
            $0.leading.equalTo(currentMonthLabel.snp.trailing).offset(33)
            $0.centerY.equalTo(currentMonthLabel)
            $0.width.equalTo(7.28)
            $0.height.equalTo(13)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().offset(-21)
            $0.top.equalTo(currentMonthLabel.snp.bottom).offset(27)
            $0.bottom.equalTo(showOrHideDateButton.snp.top).offset(-6.5)
        }
        
        showOrHideDateButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-11)
            $0.width.equalTo(15)
            $0.height.equalTo(8)
        }
    }
    
    func setAction() {
        previousMonthButton.addTarget(self, action: #selector( previousMonthButtonTapped), for: .touchUpInside)
    }
    
    @objc func previousMonthButtonTapped(sender: UIButton!) {
        if currentMonth == 1 {
            currentMonth = 12
        } else {
            currentMonth -= 1
        }
        currentMonthLabel.text = "\(currentMonth)월"
    }
}

extension CalendarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as? CalendarCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.bounds.width / 7.0, height: collectionView.bounds.height / 7.0)
//    }
}
