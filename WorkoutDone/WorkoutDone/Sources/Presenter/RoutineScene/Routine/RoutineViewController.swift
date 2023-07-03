//
//  RoutineViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/05.
//

import UIKit

class RoutineViewController : BaseViewController {
    let routineViewModel = RoutineViewModel()
    var myRoutines = [MyRoutine]()
    var selectedRoutines = [Bool]()
    var preSelectedIndex : Int = -1
    
    var isDeleteMode : Bool = false
    var selectedDeleteRoutines = [Bool]()
    
    private var deleteRoutineButton = DeleteRoutineButton()
    
    private let routineTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(RoutineCell.self, forCellReuseIdentifier: "routineCell")
        $0.register(RoutineDetailCell.self, forCellReuseIdentifier: "routineDetailCell")
        $0.register(EmptyRoutineCell.self, forCellReuseIdentifier: "emptyRoutineCell")
        $0.separatorStyle = .none
        $0.sectionHeaderHeight = 0
        $0.sectionFooterHeight = 0
        $0.backgroundColor = .colorFFFFFF
    }
    
    let tableViewContainerView = UIView(frame:.zero)
    
    private var createdButton = GradientButton(colors: [UIColor.color8E36FF.cgColor, UIColor.color7442FF.cgColor]).then {
        $0.setTitle("루틴 만들기", for: .normal)
        $0.titleLabel?.font = .pretendard(.semiBold, size: 20)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .colorFFFFFF
        title = "나의 운동 루틴"
        
        myRoutines = routineViewModel.loadMyRoutine()
        selectedRoutines = Array(repeating: false, count: myRoutines.count)
        selectedDeleteRoutines = Array(repeating: false, count: myRoutines.count)
        
        setDeleteRoutineButton()
    }
    
    override func setupLayout() {
        [routineTableView, createdButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        routineTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
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
        routineTableView.delegate = self
        routineTableView.dataSource = self
    }
    
    override func actions() {
        createdButton.addTarget(self, action: #selector(createdButtonTapped), for: .touchUpInside)
    }
    
    func loadMyRoutine() {
        myRoutines = routineViewModel.loadMyRoutine()
        selectedRoutines = Array(repeating: false, count: myRoutines.count)
        
        routineTableView.reloadData()
    }
    
    func setDeleteRoutineButton() {
        if !myRoutines.isEmpty {
            deleteRoutineButton = DeleteRoutineButton(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
            deleteRoutineButton.addTarget(self, action: #selector(deleteRoutineButtonTapped), for: .touchUpInside)
            let rightBarButton = UIBarButtonItem(customView: deleteRoutineButton)
            navigationItem.rightBarButtonItem = rightBarButton
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc func deleteRoutineButtonTapped() {
        selectedRoutines = Array(repeating: false, count: myRoutines.count)
        selectedDeleteRoutines = Array(repeating: false, count: myRoutines.count)
        
        if !isDeleteMode {
            enterDeleteMode()
        } else {
            exitDeleteMode()
        }
        
        isDeleteMode = !isDeleteMode

        routineTableView.reloadData()
    }
    
    func enterDeleteMode() {
        deleteRoutineButton.setDeleteRoutineButton(text: "뒤로 가기", textColor: .color363636, backgroundColor: .colorF3F3F3)
        createdButton.setTitle("루틴 삭제하기", for: .normal)
        createdButton.colors = [UIColor.colorF54968.cgColor, UIColor.colorF54968.cgColor]
    }
    
    func exitDeleteMode() {
        deleteRoutineButton.setDeleteRoutineButton(text: "루틴 삭제", textColor: .colorF54968, backgroundColor: .colorFFEDF0)
        createdButton.setTitle("루틴 만들기", for: .normal)
        createdButton.colors = [UIColor.color8E36FF.cgColor, UIColor.color7442FF.cgColor]
    }
    
    @objc func createdButtonTapped(sender: UIButton!) {
        if !isDeleteMode {
            let createRoutineVC = CreateRoutineViewController()
            createRoutineVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(createRoutineVC, animated: false)
        } else {
            var myRoutineId = [String]()
            for (index, isSelect) in selectedDeleteRoutines.enumerated() {
                if isSelect {
                    myRoutineId.append(myRoutines[index].id)
                }
            }
            
            if !myRoutineId.isEmpty {
                let deleteRoutineAlertVC = DeleteRoutineAlertViewController()
                deleteRoutineAlertVC.delegate = self
                deleteRoutineAlertVC.myRoutineId = myRoutineId
                deleteRoutineAlertVC.modalPresentationStyle = .overFullScreen
                self.present(deleteRoutineAlertVC, animated: false)
            }
        }
    }
}

extension RoutineViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return myRoutines.count == 0 ? 1 : myRoutines.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myRoutines.count > 0 && selectedRoutines[section] == true {
            return myRoutines[section].myWeightTraining.count + 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if myRoutines.count == 0 {
            return 0.1
        } else if section == 0 {
            return 23
        }
        return 14
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if myRoutines.count == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "emptyRoutineCell", for: indexPath) as? EmptyRoutineCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            return cell
        }
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "routineCell", for: indexPath) as? RoutineCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.delegate = self
            
            cell.routineIndexLabel.text = "routine \(indexPath.routineOrder)"
            cell.routineTitleLabel.text = myRoutines[indexPath.section].name
            
            cell.routineIndexLabel.textColor = .color7442FF
            cell.outerView.backgroundColor = .colorF6F6F6
            cell.innerBackgroundView.backgroundColor = .clear
            cell.innerView.backgroundColor = .clear
            cell.editButton.isHidden = true
            cell.openImage.isHidden = false
            
            if selectedRoutines[indexPath.section] {
                cell.editButton.isHidden = false
                cell.openImage.isHidden = true
                cell.outerView.backgroundColor = .colorF8F6FF
            }
            
            if isDeleteMode {
                cell.openImage.isHidden = true
                if selectedDeleteRoutines[indexPath.section] {
                    cell.routineIndexLabel.textColor = .colorF54968
                    cell.outerView.backgroundColor = .colorF54968
                    cell.innerBackgroundView.backgroundColor = .colorFFFFFF
                    cell.innerView.backgroundColor = .colorF54968.withAlphaComponent(0.2)
                }
            }
            
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "routineDetailCell", for: indexPath) as? RoutineDetailCell else { return UITableViewCell() }
        cell.selectionStyle = .none

        cell.bodyPartLabel.text = myRoutines[indexPath.section].myWeightTraining[indexPath.row - 1].myBodyPart
        cell.weightTrainingLabel.text = myRoutines[indexPath.section].myWeightTraining[indexPath.row - 1].myWeightTraining

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if myRoutines.count == 0 {
            return tableView.frame.height
        }
        
        if indexPath.row == 0 {
            return selectedRoutines[indexPath.section] == true ? 65 : 53
        }
        return 58
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        
        let outerView = UIView(frame: .init(x: 20, y: 0, width: tableView.bounds.width - 40, height: selectedRoutines[section] == true ? 19 : 17))
        let innerBackgroundView = UIView(frame: .init(x: 1, y: 0, width: outerView.bounds.width - 2, height: outerView.bounds.height - 1))
        let innerView = UIView(frame: .init(x: 0, y: 0, width: innerBackgroundView.bounds.width, height: innerBackgroundView.bounds.height))
        
        footer.addSubview(outerView)
        outerView.addSubview(innerBackgroundView)
        innerBackgroundView.addSubview(innerView)
        
        outerView.backgroundColor = .colorF6F6F6
        outerView.layer.cornerRadius = 10
        outerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        innerBackgroundView.backgroundColor = .clear
        innerBackgroundView.layer.cornerRadius = 10
        innerBackgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        innerView.backgroundColor = .clear
        innerView.layer.cornerRadius = 10
        innerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        if selectedRoutines[section] {
            outerView.backgroundColor = .colorF8F6FF
        }
        
        if isDeleteMode && selectedDeleteRoutines[section] {
            outerView.backgroundColor = .colorF54968
            innerBackgroundView.backgroundColor = .colorFFFFFF
            innerView.backgroundColor = .colorF54968.withAlphaComponent(0.2)
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(routineCellTapped))
        outerView.addGestureRecognizer(tapGesture)
        outerView.tag = section
       
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if myRoutines.count > 0 {
            return selectedRoutines[section] == true ? 19 : 17
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if myRoutines.count > 0, indexPath.row == 0 {
            if !isDeleteMode {
                if !selectedRoutines[indexPath.section] {
                    if preSelectedIndex >= 0 {
                        selectedRoutines[preSelectedIndex] = false
                        tableView.reloadSections([preSelectedIndex], with: .none)
                    }
                    
                    preSelectedIndex = indexPath.section
                }
                
                selectedRoutines[indexPath.section] = !selectedRoutines[indexPath.section]
                
                tableView.reloadSections([indexPath.section], with: .none)
            } else {
                selectedDeleteRoutines[indexPath.section] = !selectedDeleteRoutines[indexPath.section]
                
                tableView.reloadData()
            }
        }
    }
    
    @objc func routineCellTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let footerView = gestureRecognizer.view else { return }
        let section = footerView.tag
        
        if !isDeleteMode {
            if !selectedRoutines[section] {
                if preSelectedIndex >= 0 {
                    selectedRoutines[preSelectedIndex] = false
                    routineTableView.reloadSections([preSelectedIndex], with: .none)
                }
                
                preSelectedIndex = section
            }

            selectedRoutines[section] = !selectedRoutines[section]
            
            routineTableView.reloadSections([section], with: .none)
        } else {
            selectedDeleteRoutines[section] = !selectedDeleteRoutines[section]
            
            routineTableView.reloadData()
        }
    }
}

extension RoutineViewController : EditDelegate, AlertDismissDelegate {
    func editButtonTapped() {
        let createRoutineVC = CreateRoutineViewController()
        createRoutineVC.hidesBottomBarWhenPushed = true
        createRoutineVC.myWeightTraining = Array(myRoutines[preSelectedIndex].myWeightTraining)
        createRoutineVC.routineId = myRoutines[preSelectedIndex].id
        navigationController?.pushViewController(createRoutineVC, animated: false)
    }
    
    func didDismissDeleteRoutineAlertViewController() {
        myRoutines = routineViewModel.loadMyRoutine()
        selectedRoutines = Array(repeating: false, count: myRoutines.count)
        selectedDeleteRoutines = Array(repeating: false, count: myRoutines.count)
        
        if myRoutines.isEmpty {
            deleteRoutineButtonTapped()
        }
        
        setDeleteRoutineButton()
        
        routineTableView.reloadData()
    }
}
