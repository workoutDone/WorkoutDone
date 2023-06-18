//
//  WorkoutViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/14.
//

import UIKit

class WorkoutViewController : BaseViewController {
    let routineViewModel = RoutineViewModel()
    var myRoutines = [MyRoutine]()
    var selectedRoutines = [Bool]()
    var preSelectedIndex : Int = -1
    var weightTraining = [WeightTraining]()
    
    var isSelectBodyPartIndex : Int = -1 // 선택 카테고리 index
    var selectedMyRoutineCount : Int = 0 // 나의 루틴의 운동 갯수
    var selectedCount : Int = 0 // 운동 갯수
    var selectedMyRoutineIndex : Int = -1 // 나의 루틴 순서
    
    let sampleData = [BodyPartData(bodyPart: "가슴", weigthTraing: ["벤치 프레스", "디클라인 푸시업", "버터플라이", "인클라인 덤벨 체스트플라이", "벤치 프레스2", "디클라인 푸시업2", "버터플라이2", "인클라인 덤벨 체스트플라이2", "벤치 프레스3", "디클라인 푸시업3", "버터플라이3", "인클라인 덤벨 체스트플라이3"]), BodyPartData(bodyPart: "등", weigthTraing: ["등0", "등1"]), BodyPartData(bodyPart: "하체", weigthTraing: ["하체0", "하체1", "하체2"]), BodyPartData(bodyPart: "어깨", weigthTraing: []), BodyPartData(bodyPart: "삼두", weigthTraing: []), BodyPartData(bodyPart: "이두", weigthTraing: []), BodyPartData(bodyPart: "졸려", weigthTraing: []), BodyPartData(bodyPart: "하암", weigthTraing: [])]
    
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
        
        myRoutines = routineViewModel.loadMyRoutine()
        selectedRoutines = Array(repeating: false, count: myRoutines.count)
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
            $0.bottom.equalTo(selectCompleteButton.snp.top)
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
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
    }
    
    override func setComponents() {
        bodyPartCollectionView.delegate = self
        bodyPartCollectionView.dataSource = self
        
        routineTableView.delegate = self
        routineTableView.dataSource = self
    }
    
    override func actions() {
        selectCompleteButton.addTarget(self, action: #selector(selectCompleteButtonTapped), for: .touchUpInside)
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
    
    @objc func selectCompleteButtonTapped(sender: UIButton!) {
        if selectedMyRoutineCount + selectedCount > 0 {
            let workoutSequenceVC = WorkoutSequenceViewController()
            navigationController?.pushViewController(workoutSequenceVC, animated: false)
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
            return myRoutines.count == 0 ? 1 : myRoutines.count
        }
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSelectBodyPartIndex == -1 {
            if myRoutines.count > 0 && selectedRoutines[section] == true {
                return myRoutines[section].myWeightTraining.count + 1
            }
            return 1
        }
        return sampleData[isSelectBodyPartIndex].weigthTraing.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSelectBodyPartIndex == -1 {
            if myRoutines.count == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "createRoutineCell", for: indexPath) as? CreateRoutineCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.delegate = self
                return cell
            }
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "myRoutineCell", for: indexPath) as? MyRoutineCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                cell.routineIndexLabel.text = "routine \(indexPath.routineOrder)"
                cell.routineTitleLabel.text = myRoutines[indexPath.section].name
                cell.openImage.image = UIImage(named: "open")
                
                cell.selectedIndexView.isHidden = true
                cell.outerView.backgroundColor = .colorF6F6F6
                
                if selectedRoutines[indexPath.section] == true {
                    cell.openImage.image = UIImage(named: "routineHide")
                    cell.selectedIndexLabel.text = "\(selectedMyRoutineCount)"
                    
                    cell.selectedIndexView.isHidden = false
                    cell.outerView.backgroundColor = .colorF8F6FF
                }

                return cell
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "myRoutineDetailCell", for: indexPath) as? MyRoutineDetailCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            cell.bodyPartLabel.text = myRoutines[indexPath.section].myWeightTraining[indexPath.row - 1].myBodyPart
            cell.weightTrainingLabel.text = myRoutines[indexPath.section].myWeightTraining[indexPath.row - 1].myWeightTraining

            return cell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weightTrainingCell", for: indexPath) as? WeightTrainingCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.weightTrainingLabel.text = sampleData[isSelectBodyPartIndex].weigthTraing[indexPath.row]

        cell.weightTraingView.backgroundColor = .colorF6F6F6
        cell.weightTrainingLabel.font = .pretendard(.regular, size: 16)
        
        cell.selectedIndexView.isHidden = true
  
        for (index, training) in weightTraining.enumerated() {
            if training.bodyPart == sampleData[isSelectBodyPartIndex].bodyPart && training.weightTraining == sampleData[isSelectBodyPartIndex].weigthTraing[indexPath.row] {
                cell.selectedIndexLabel.text = "\(index + 1)"
                cell.selectedIndexView.isHidden = false
                
                cell.weightTraingView.backgroundColor = .colorE6E0FF
                cell.weightTrainingLabel.font = .pretendard(.semiBold, size: 16)
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isSelectBodyPartIndex == -1 {
            if myRoutines.count == 0 {
                return 127
            }

            if indexPath.row == 0 {
                return selectedRoutines[indexPath.section] == true ? 73 : 61
            }
            return 58
        }
        return 64
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isSelectBodyPartIndex == -1 {
            if myRoutines.count == 0 {
                return 27
            }
            if section == 0 {
                return 15
            }
            return 6
        }
        return 9
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()

        if isSelectBodyPartIndex == -1 {
            let outerView = UIView(frame: .init(x: 20, y: 0, width: tableView.bounds.width - 40, height: selectedRoutines[section] == true ? 11 : 17))
            footer.addSubview(outerView)
            
            outerView.backgroundColor = .colorF6F6F6
            outerView.layer.cornerRadius = 10
            outerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            
            if selectedRoutines[section] {
                outerView.backgroundColor = .colorF8F6FF
            }

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(routineCellTapped))
            outerView.addGestureRecognizer(tapGesture)
            outerView.tag = section
        }

        return footer
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if isSelectBodyPartIndex == -1 {
            if myRoutines.count == 0 {
                return 0
            }
            return selectedRoutines[section] == true ? 11 : 17
        }
        return 20
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSelectBodyPartIndex == -1 {
            if myRoutines.count > 0 && indexPath.row == 0 {
                if !selectedRoutines[indexPath.section] {
                    if preSelectedIndex >= 0 {
                        selectedRoutines[preSelectedIndex] = false
                        
                        tableView.reloadSections([preSelectedIndex], with: .none)
                    }
                    
                    preSelectedIndex = indexPath.section
                    selectedRoutines[indexPath.section] = true
                    
                    selectedMyRoutineCount = myRoutines[indexPath.section].myWeightTraining.count
                } else {
                    selectedRoutines[indexPath.section] = false
                    selectedMyRoutineCount = 0
                }
                
                selectedMyRoutineIndex = weightTraining.count + 1
                
                tableView.reloadSections([indexPath.section], with: .none)
            }
        } else {
            if let index = weightTraining.firstIndex(where: {$0.weightTraining == sampleData[isSelectBodyPartIndex].weigthTraing[indexPath.row]}) {
                weightTraining.remove(at: index)
            } else {
                weightTraining.append(WeightTraining(bodyPart: sampleData[isSelectBodyPartIndex].bodyPart, weightTraining: sampleData[isSelectBodyPartIndex].weigthTraing[indexPath.row]))
            }
            
            selectedCount = weightTraining.count
        }
        
        routineTableView.reloadData()
        updateSelectCompleteButton()
    }

    @objc func routineCellTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        if isSelectBodyPartIndex == -1 {
            guard let footerView = gestureRecognizer.view else { return }
            let section = footerView.tag

            if !selectedRoutines[section] {
                if preSelectedIndex >= 0 {
                    selectedRoutines[preSelectedIndex] = false
                    
                    routineTableView.reloadSections([preSelectedIndex], with: .none)
                }
                
                preSelectedIndex = section
                selectedRoutines[section] = true
                selectedMyRoutineCount = myRoutines[section].myWeightTraining.count
            } else {
                selectedRoutines[section] = false
                selectedMyRoutineCount = 0
            }
            
            selectedMyRoutineIndex = weightTraining.count + 1
            
            routineTableView.reloadSections([section], with: .none)
        }

        updateSelectCompleteButton()
    }
}
