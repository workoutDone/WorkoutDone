//
//  CreateRoutineViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/17.
//

import UIKit

class CreateRoutineViewController : BaseViewController {
    var isSelected : Bool = false
    var weightTrainings = ["벤치 프레스", "디클라인 푸시업", "버터플라이", "인클라인 덤벨 체스트플라이", "벤치 프레스", "디클라인 푸시업", "버터플라이", "인클라인 덤벨 체스트플라이", "벤치 프레스", "디클라인 푸시업", "버터플라이", "인클라인 덤벨 체스트플라이"]
    
    private let weightTrainingCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BodyPartHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "bodyPartHeaderView")
        collectionView.register(WeightTrainingCell.self, forCellWithReuseIdentifier: "weightTrainingCell")

        return collectionView
    }()
    
    var selectedIndexView = UIView().then {
        $0.backgroundColor = .color7442FF
        $0.layer.cornerRadius = 12
    }
    
    var selectedIndexLabel = UILabel().then {
        $0.text = "0"
        $0.textColor = .colorFFFFFF
        $0.font = .pretendard(.semiBold, size: 15)
    }
    
    
    
    // [UIColor.color8E36FF.cgColor, UIColor.color7442FF.cgColor]
    private let selectCompleteButtonButton = GradientButton(colors: [UIColor.colorCCCCCC.cgColor, UIColor.colorCCCCCC.cgColor]).then {
        $0.setTitle("다 골랐어요", for: .normal)
        $0.titleLabel?.font = .pretendard(.bold, size: 20)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .colorFFFFFF
        title = "나의 운동 루틴"
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        [weightTrainingCollectionView, selectCompleteButtonButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        weightTrainingCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(109)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        selectCompleteButtonButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.bottom.equalToSuperview().offset(-55)
            $0.height.equalTo(58)
        }
    }
    
    override func setComponents() {
        weightTrainingCollectionView.delegate = self
        weightTrainingCollectionView.dataSource = self
    }
}

extension CreateRoutineViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "bodyPartHeaderView", for: indexPath) as? BodyPartHeaderView else { return BodyPartHeaderView() }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weightTrainings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weightTrainingCell", for: indexPath) as? WeightTrainingCell else { return UICollectionViewCell() }
        cell.weightTrainingLabel.text = weightTrainings[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 23, left: 40, bottom: 23, right: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 78, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

