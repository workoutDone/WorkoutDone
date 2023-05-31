//
//  WorkoutViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/14.
//

import UIKit

class WorkoutViewController : BaseViewController {
    var isSelectBodyPartIndex : Int = -1
    var preSelectedIndex : Int = -1
    var selectedMyRoutineCount : Int = 0
    var selectedCount : Int = 0
    var isSelectWeightTraings = [[String]]()
    
    var myRoutineSampleData =
    [
        MyRoutineData(title: "오늘은 등 운동!", category: [CategoryData(categoryName: "어깨", training: "배틀 로프")], opend: false),
        MyRoutineData(title: "어깨 몸짱 가보자고", category: [CategoryData(categoryName: "어깨", training: "배틀 로프"), CategoryData(categoryName: "어깨", training: "클린 앤 저크"), CategoryData(categoryName: "어깨", training: "플란체")], opend: false),
        MyRoutineData(title: "바프를 향해 데일리루틴", category: [CategoryData(categoryName: "냠냠", training: "냠냠")], opend: false)
    ]
    
    let sampleData = [BodyPartData(bodyPart: "가슴", weigthTraing: ["벤치 프레스", "디클라인 푸시업", "버터플라이", "인클라인 덤벨 체스트플라이", "벤치 프레스2", "디클라인 푸시업2", "버터플라이2", "인클라인 덤벨 체스트플라이2", "벤치 프레스3", "디클라인 푸시업3", "버터플라이3", "인클라인 덤벨 체스트플라이3"]), BodyPartData(bodyPart: "등", weigthTraing: ["벤치 프레스0"]), BodyPartData(bodyPart: "하체", weigthTraing: []), BodyPartData(bodyPart: "어깨", weigthTraing: []), BodyPartData(bodyPart: "삼두", weigthTraing: []), BodyPartData(bodyPart: "이두", weigthTraing: []), BodyPartData(bodyPart: "졸려", weigthTraing: []), BodyPartData(bodyPart: "하암", weigthTraing: [])]
    
    private let bodyPartCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MyRoutineHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "myRoutineHeaderView")
        collectionView.register(BodyPartCell.self, forCellWithReuseIdentifier: "bodyPartCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .colorF8F6FF
        
        return collectionView
    }()
    
    private let routineTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(CreateRoutineCell.self, forCellReuseIdentifier: "createRoutineCell")
        $0.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        $0.register(MyRoutineCell.self, forCellReuseIdentifier: "myRoutineCell")
        $0.register(MyRoutineDetailCell.self, forCellReuseIdentifier: "myRoutineDetailCell")
        $0.register(WeightTrainingCell.self, forCellReuseIdentifier: "weightTrainingCell")
        $0.separatorStyle = .none
        $0.sectionHeaderHeight = 0
        $0.sectionFooterHeight = 0
        $0.backgroundColor = .colorFFFFFF
    }
    
    // [UIColor.color8E36FF.cgColor, UIColor.color7442FF.cgColor]
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
    
    private var adImage = UIImageView().then {
        $0.backgroundColor = .color3ED1FF.withAlphaComponent(0.2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        
        title = "운동하기"
        view.backgroundColor = .colorFFFFFF
        
        isSelectWeightTraings = Array(repeating: [], count: sampleData.count)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        [bodyPartCollectionView, routineTableView, selectCompleteButton, adImage].forEach {
            view.addSubview($0)
        }
        
        [selectCompleteButtonCountLabel, selectCompleteButtonLabel].forEach {
            selectCompleteButton.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        bodyPartCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(99)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        routineTableView.snp.makeConstraints {
            $0.top.equalTo(bodyPartCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(adImage.snp.top)
        }
        
        selectCompleteButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.bottom.equalTo(adImage.snp.top).offset(-29)
            $0.height.equalTo(58)
        }
        
        selectCompleteButtonLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(selectCompleteButton)
        }
        
        selectCompleteButtonCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(selectCompleteButton)
            $0.trailing.equalTo(selectCompleteButtonLabel.snp.leading).offset(-5)
        }
        
        adImage.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    override func setComponents() {
        bodyPartCollectionView.delegate = self
        bodyPartCollectionView.dataSource = self
        
        routineTableView.delegate = self
        routineTableView.dataSource = self
    }
    
    func updateSelectCompleteButton() {
        if selectedMyRoutineCount + selectedCount == 0 {
            selectCompleteButton.gradient.colors = [UIColor.colorCCCCCC.cgColor, UIColor.colorCCCCCC.cgColor]
            selectCompleteButtonCountLabel.text = ""
        } else {
            selectCompleteButton.gradient.colors = [UIColor.color8E36FF.cgColor, UIColor.color7442FF.cgColor]
            selectCompleteButtonCountLabel.text = "\(selectedMyRoutineCount + selectedCount)"
        }
    }
}

extension WorkoutViewController : MyRoutineDelegate, CreateRoutineDelegate {
    func myRoutineButtonTapped() {
        isSelectBodyPartIndex = -1
        bodyPartCollectionView.reloadData()
        routineTableView.reloadData()
    }
    
    func createRoutineButtonTapped() {
        let createRoutineVC = CreateRoutineViewController()
        navigationController?.pushViewController(createRoutineVC, animated: false)
    }
}


extension WorkoutViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "myRoutineHeaderView", for: indexPath) as? MyRoutineHeaderView else { return MyRoutineHeaderView() }
        headerView.delegate = self
        if isSelectBodyPartIndex == -1 {
            headerView.myRoutineButton.backgroundColor = .colorE6E0FF
            headerView.myRoutineButton.setTitleColor(.color7442FF, for: .normal)
            headerView.myRoutineButton.titleLabel?.font = .pretendard(.semiBold, size: 16)
        } else {
            headerView.myRoutineButton.backgroundColor = .clear
            headerView.myRoutineButton.setTitleColor(.colorC8B4FF, for: .normal)
            headerView.myRoutineButton.titleLabel?.font = .pretendard(.regular, size: 16)
        }
       
        return headerView
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 104, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8.5, left: 9, bottom: 10.5, right: 19)
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = sampleData[indexPath.row].bodyPart.size(withAttributes: nil).width + 7.3
        return CGSize(width: width + 24, height: 31)
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 21
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isSelectBodyPartIndex = indexPath.row
        bodyPartCollectionView.reloadData()
        routineTableView.reloadData()
       
    }
}


extension WorkoutViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSelectBodyPartIndex == -1 {
            return myRoutineSampleData.count == 0 ? 1 : myRoutineSampleData.count
        }
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSelectBodyPartIndex == -1 {
            if myRoutineSampleData.count > 0 && myRoutineSampleData[section].opend == true {
                return myRoutineSampleData[section].category.count + 1
            }
            return 1
        }
        return sampleData[isSelectBodyPartIndex].weigthTraing.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSelectBodyPartIndex == -1 {
            if myRoutineSampleData.count == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "createRoutineCell", for: indexPath) as? CreateRoutineCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.delegate = self
                return cell
            }
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "myRoutineCell", for: indexPath) as? MyRoutineCell else { return UITableViewCell() }
                cell.selectionStyle = .none
               
                return cell
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "myRoutineDetailCell", for: indexPath) as? MyRoutineDetailCell else { return UITableViewCell() }
            cell.selectionStyle = .none
           
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weightTrainingCell", for: indexPath) as? WeightTrainingCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.weightTrainingLabel.text = sampleData[isSelectBodyPartIndex].weigthTraing[indexPath.row]
        
        cell.weightTraingView.layer.borderColor = UIColor.colorCCCCCC.cgColor
        cell.weightTraingView.backgroundColor = .colorFFFFFF
        cell.weightTrainingLabel.font = .pretendard(.regular, size: 16)
        
        if let index = isSelectWeightTraings[isSelectBodyPartIndex].firstIndex(of: sampleData[isSelectBodyPartIndex].weigthTraing[indexPath.row]) {
            cell.weightTraingView.layer.borderColor = UIColor.color7442FF.cgColor
            cell.weightTraingView.backgroundColor = .colorF8F6FF
            cell.weightTrainingLabel.font = .pretendard(.semiBold, size: 16)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isSelectBodyPartIndex == -1 {
            if myRoutineSampleData.count == 0 {
                return 127
            }
            
            if indexPath.row == 0 {
                return myRoutineSampleData[indexPath.section].opend == true ? 65 : 53
            }
            return 58
        }
     
        return 64
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isSelectBodyPartIndex == -1 {
            if section == 0 {
                return 23
            }
            return 14
        }
        return 9
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        
        if isSelectBodyPartIndex == -1 {
            let outerView = UIView(frame: .init(x: 20, y: 0, width: tableView.bounds.width - 40, height: 20))
            let innerView = UIView(frame: .init(x: 1, y: -1, width: outerView.bounds.width - 2, height: outerView.bounds.height))
            footer.addSubview(outerView)
            outerView.addSubview(innerView)
            
            outerView.backgroundColor = .colorCCCCCC
            outerView.layer.cornerRadius = 10
            outerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            
            innerView.backgroundColor = .colorFFFFFF
            innerView.layer.cornerRadius = 10
            innerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(routineCellTapped))
            innerView.addGestureRecognizer(tapGesture)
            innerView.tag = section
        }
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if isSelectBodyPartIndex == -1 {
            return myRoutineSampleData[section].opend == true ? 19 : 17
        }
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSelectBodyPartIndex == -1 {
            if myRoutineSampleData.count > 0 && indexPath.row == 0 {
                if !myRoutineSampleData[indexPath.section].opend {
                    if preSelectedIndex >= 0 {
                        myRoutineSampleData[preSelectedIndex].opend = false
                        tableView.reloadSections([preSelectedIndex], with: .none)
                    }
                    
                    preSelectedIndex = indexPath.section
                }
                
                if myRoutineSampleData[indexPath.section].opend {
                    myRoutineSampleData[indexPath.section].opend = false
                    selectedMyRoutineCount = 0
                } else {
                    myRoutineSampleData[indexPath.section].opend = true
                    selectedMyRoutineCount = myRoutineSampleData[indexPath.section].category.count
                }
         
                tableView.reloadSections([indexPath.section], with: .none)
            }
            
        } else {
            if let index = isSelectWeightTraings[isSelectBodyPartIndex].firstIndex(of: sampleData[isSelectBodyPartIndex].weigthTraing[indexPath.row]) {
                isSelectWeightTraings[isSelectBodyPartIndex].remove(at: index)
                selectedCount -= 1
            } else {
                isSelectWeightTraings[isSelectBodyPartIndex].append(sampleData[isSelectBodyPartIndex].weigthTraing[indexPath.row])
                selectedCount += 1
            }
            
            routineTableView.reloadData()
        }
        
        updateSelectCompleteButton()
    }
    
    @objc func routineCellTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        if isSelectBodyPartIndex == -1 {
            guard let footerView = gestureRecognizer.view else { return }
            let section = footerView.tag

            if !myRoutineSampleData[section].opend {
                if preSelectedIndex >= 0 {
                    myRoutineSampleData[preSelectedIndex].opend = false
                    routineTableView.reloadSections([preSelectedIndex], with: .none)
                }
                
                preSelectedIndex = section
            }
       
            if myRoutineSampleData[section].opend {
                myRoutineSampleData[section].opend = false
                selectedMyRoutineCount = 0
            } else {
                myRoutineSampleData[section].opend = true
                selectedMyRoutineCount = myRoutineSampleData[section].category.count
            }
            
            routineTableView.reloadSections([section], with: .none)
        }
        
        updateSelectCompleteButton()
    }
}
