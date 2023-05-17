//
//  RoutineViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/05.
//

import UIKit

struct MyRoutineData {
    var title : String
    var category : [CategoryData]
}

struct CategoryData {
    var categoryName : String
    var training : String
}

class RoutineViewController : BaseViewController {
    let sampleData = [
        MyRoutineData(title: "오늘은 등 운동!", category: [CategoryData(categoryName: "냠냠", training: "냠냠")]),
        MyRoutineData(title: "어깨 몸짱 가보자고", category: [CategoryData(categoryName: "어깨", training: "배틀 로프"), CategoryData(categoryName: "어깨", training: "클린 앤 저크"), CategoryData(categoryName: "어깨", training: "플란체")]),
        MyRoutineData(title: "바프를 향해 데일리루틴", category: [CategoryData(categoryName: "냠냠", training: "냠냠")])
    ]

    var selectedIndex : Int = -1
    
    private let createdButton = GradientButton(colors: [UIColor.color8E36FF.cgColor, UIColor.color7442FF.cgColor]).then {
        $0.setTitle("루틴 만들기", for: .normal)
        $0.titleLabel?.font = .pretendard(.semiBold, size: 20)
    }
    
    private var routineCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RoutineHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "routineHeaderView")
        collectionView.register(RoutineCell.self, forCellWithReuseIdentifier: "routineCell")
        collectionView.register(EmptyRoutineCell.self, forCellWithReuseIdentifier: "emptyRoutineCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .colorFFFFFF
        title = "나의 운동 루틴"
    }
    
    override func setupLayout() {
        view.addSubview(routineCollectionView)
        view.addSubview(createdButton)
    }
    
    override func setupConstraints() {
        routineCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(120)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(createdButton.snp.top)
        }
        
        createdButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.bottom.equalToSuperview().offset(-28)
            $0.height.equalTo(58)
        }
    }
    
    override func setComponents() {
        routineCollectionView.delegate = self
        routineCollectionView.dataSource = self
    }
    
    override func actions() {
        createdButton.addTarget(self, action: #selector(createdButtonTapped), for: .touchUpInside)
    }
    
    @objc func createdButtonTapped(sender: UIButton!) {
        let createRoutineVC = CreateRoutineViewController()
        createRoutineVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(createRoutineVC, animated: false)
    }
}

extension RoutineViewController : RoutineDelegate {
    func didSelectRoutine(index: Int) {
        if selectedIndex == index {
            selectedIndex = -1
        } else {
            selectedIndex = index
        }

        routineCollectionView.reloadData()
    }
}

extension RoutineViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sampleData.count == 0 ? 1 : sampleData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleData.count == 0 ? 1 : (selectedIndex == section ? sampleData[section].category.count : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "routineHeaderView", for: indexPath) as? RoutineHeaderView else { return RoutineHeaderView() }
        header.delegate = self
        header.editButton.isHidden = true
        header.backgroundButton.layer.borderColor = UIColor.colorCCCCCC.cgColor
        
        if indexPath.section == selectedIndex {
            header.editButton.isHidden = false
            header.backgroundButton.layer.borderColor = UIColor.color7442FF.cgColor
        }
        header.seletedIndex = indexPath.section
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if sampleData.count == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyRoutineCell", for: indexPath) as? EmptyRoutineCell else { return UICollectionViewCell() }
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "routineCell", for: indexPath) as? RoutineCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return sampleData.count == 0 ? CGSize(width: 0, height: 0) : CGSize(width: collectionView.frame.width, height: 70)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 14, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sampleData.count == 0 ? CGSize(width: collectionView.frame.width - 80, height: collectionView.frame.height) : CGSize(width: collectionView.frame.width - 80, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
