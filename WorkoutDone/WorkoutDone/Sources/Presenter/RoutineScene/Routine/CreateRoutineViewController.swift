//
//  CreateRoutineViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/17.
//

import UIKit

struct BodyPartData {
    let bodyPart : String
    let weigthTraing : [String]
}

class CreateRoutineViewController : BaseViewController {
    let sampleData = [BodyPartData(bodyPart: "가슴", weigthTraing: ["벤치 프레스", "디클라인 푸시업", "버터플라이", "인클라인 덤벨 체스트플라이", "벤치 프레스2", "디클라인 푸시업2", "버터플라이2", "인클라인 덤벨 체스트플라이2", "벤치 프레스3", "디클라인 푸시업3", "버터플라이3", "인클라인 덤벨 체스트플라이3"]), BodyPartData(bodyPart: "등", weigthTraing: ["벤치 프레스0"]), BodyPartData(bodyPart: "하체", weigthTraing: []), BodyPartData(bodyPart: "어깨", weigthTraing: []), BodyPartData(bodyPart: "삼두", weigthTraing: []), BodyPartData(bodyPart: "이두", weigthTraing: []), BodyPartData(bodyPart: "졸려", weigthTraing: []), BodyPartData(bodyPart: "하암", weigthTraing: [])]
    
    var isSelectBodyPartIndex = 0
    var isSelectWeightTraings = [[String]]()
    var selectedCount = 0
    
    private let bodyPartCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BodyPartCell.self, forCellWithReuseIdentifier: "bodyPartCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .colorF8F6FF
        
        return collectionView
    }()
    
    private let weightTrainingCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WeightTrainingCell.self, forCellWithReuseIdentifier: "weightTrainingCell")

        return collectionView
    }()

    private let selectCompleteButton = GradientButton(colors: [UIColor.colorCCCCCC.cgColor, UIColor.colorCCCCCC.cgColor])
    
    private let selectCompleteButtonCountLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .colorC8B4FF
        $0.font = .pretendard(.regular, size: 20)
    }
    
    private let selectCompleteButtonLabel = UILabel().then {
        $0.text = "다 골랐어요"
        $0.textColor = .colorFFFFFF
        $0.font = .pretendard(.bold, size: 20)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .colorFFFFFF
        title = "루틴 만들기"
        
        isSelectWeightTraings = Array(repeating: [], count: sampleData.count)

        setBackButton()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        [bodyPartCollectionView, weightTrainingCollectionView, selectCompleteButton].forEach {
            view.addSubview($0)
        }
        [selectCompleteButtonCountLabel, selectCompleteButtonLabel].forEach {
            selectCompleteButton.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        bodyPartCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(109)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        weightTrainingCollectionView.snp.makeConstraints {
            $0.top.equalTo(bodyPartCollectionView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        selectCompleteButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.bottom.equalToSuperview().offset(-55)
            $0.height.equalTo(58)
        }
        
        selectCompleteButtonLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(selectCompleteButton)
        }
        
        selectCompleteButtonCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(selectCompleteButton)
            $0.trailing.equalTo(selectCompleteButtonLabel.snp.leading).offset(-5)
        }
    }
    
    override func setComponents() {
        weightTrainingCollectionView.delegate = self
        weightTrainingCollectionView.dataSource = self
        
        bodyPartCollectionView.delegate = self
        bodyPartCollectionView.dataSource = self
    }
    
    func setBackButton() {
        let backButton = RoutineBackButton()
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    @objc func backButtonTapped() {
        let routineAlertVC = RoutineAlertViewController()
        routineAlertVC.modalPresentationStyle = .overCurrentContext
        routineAlertVC.delegate = self
        self.present(routineAlertVC, animated: false)
    }
}

extension CreateRoutineViewController : RoutineAlertDelegate {
    func routineDeleteButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
}

extension CreateRoutineViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bodyPartCollectionView  {
            return sampleData.count
        }
        return sampleData[isSelectBodyPartIndex].weigthTraing.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bodyPartCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bodyPartCell", for: indexPath) as? BodyPartCell else { return UICollectionViewCell() }
            cell.bodyPartLabel.text = sampleData[indexPath.row].bodyPart
            
            cell.layer.cornerRadius = 31 / 2
            cell.backgroundColor = .clear
            cell.bodyPartLabel.textColor = .colorC8B4FF
            cell.bodyPartLabel.font = .pretendard(.regular, size: 16)

            if isSelectBodyPartIndex == indexPath.row {
                cell.backgroundColor = .colorE6E0FF
                cell.bodyPartLabel.textColor = .color7442FF
                cell.bodyPartLabel.font = .pretendard(.semiBold, size: 16)
            }
        
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weightTrainingCell", for: indexPath) as? WeightTrainingCell else { return UICollectionViewCell() }
        cell.weightTrainingLabel.text = sampleData[isSelectBodyPartIndex].weigthTraing[indexPath.row]
        
        cell.weightTraingView.layer.borderColor = UIColor.colorCCCCCC.cgColor
        cell.weightTraingView.backgroundColor = .colorFFFFFF
        cell.weightTrainingLabel.font = .pretendard(.regular, size: 16)
        
        cell.selectedIndexView.isHidden = true
     
        if let index = isSelectWeightTraings[isSelectBodyPartIndex].firstIndex(of: sampleData[isSelectBodyPartIndex].weigthTraing[indexPath.row]) {

            cell.selectedIndexLabel.text = "\(index + 1)"
            cell.selectedIndexView.isHidden = false
            
            cell.weightTraingView.layer.borderColor = UIColor.color7442FF.cgColor
            cell.weightTraingView.backgroundColor = .colorF8F6FF
            cell.weightTrainingLabel.font = .pretendard(.semiBold, size: 16)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == bodyPartCollectionView {
            return UIEdgeInsets(top: 8.5, left: 19, bottom: 10.5, right: 19)
        }
        return UIEdgeInsets(top: 23, left: 40, bottom: 23, right: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bodyPartCollectionView {
            return CGSize(width: 52, height: 31)
        }
        return CGSize(width: collectionView.frame.width - 78, height: 58)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == bodyPartCollectionView {
            return 0
        }
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
          return CGSize(width: collectionView.bounds.width, height: 100)
      }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == bodyPartCollectionView {
            isSelectBodyPartIndex = indexPath.row
            bodyPartCollectionView.reloadData()
        } else {
            if let index = isSelectWeightTraings[isSelectBodyPartIndex].firstIndex(of: sampleData[isSelectBodyPartIndex].weigthTraing[indexPath.row]) {
                isSelectWeightTraings[isSelectBodyPartIndex].remove(at: index)
                selectedCount -= 1
            } else {
                isSelectWeightTraings[isSelectBodyPartIndex].append(sampleData[isSelectBodyPartIndex].weigthTraing[indexPath.row])
                selectedCount += 1
            }
            
            if selectedCount == 0 {
                selectCompleteButton.gradient.colors = [UIColor.colorCCCCCC.cgColor, UIColor.colorCCCCCC.cgColor]
                selectCompleteButtonCountLabel.text = ""
            } else {
                selectCompleteButton.gradient.colors = [UIColor.color8E36FF.cgColor, UIColor.color7442FF.cgColor]
                selectCompleteButtonCountLabel.text = "\(selectedCount)"
            }
           
        }
        weightTrainingCollectionView.reloadData()
    }
}

