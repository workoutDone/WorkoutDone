//
//  RoutineViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/05.
//

import UIKit


class RoutineViewController : BaseViewController {
    let routineViewModel = RoutineViewModel()
    var selectedRoutines = [Bool]()
    var myRoutines = [MyRoutine]()
    var preSelectedIndex : Int = -1
    
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
    
    private let createdButton = GradientButton(colors: [UIColor.color8E36FF.cgColor, UIColor.color7442FF.cgColor]).then {
        $0.setTitle("루틴 만들기", for: .normal)
        $0.titleLabel?.font = .pretendard(.semiBold, size: 20)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .colorFFFFFF
        title = "나의 운동 루틴"
        
        myRoutines = routineViewModel.loadMyRoutine()
   
        selectedRoutines = Array(repeating: false, count: myRoutines.count)
    }
    
    override func setupLayout() {
        [routineTableView, createdButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        routineTableView.snp.makeConstraints {
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
        routineTableView.delegate = self
        routineTableView.dataSource = self
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

extension RoutineViewController : EditDelegate {
    func editButtonTapped() {
        let createRoutineVC = CreateRoutineViewController()
        createRoutineVC.hidesBottomBarWhenPushed = true
        createRoutineVC.myWeightTraining = Array(myRoutines[preSelectedIndex].myWeightTraining)
        navigationController?.pushViewController(createRoutineVC, animated: false)
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
        if myRoutines.count == 0 || section == 0 {
            return 0.1
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
            cell.editButton.isHidden = true
            cell.openImage.isHidden = false
            cell.outerView.backgroundColor = .colorF6F6F6
            
            if selectedRoutines[indexPath.section] {
                cell.editButton.isHidden = false
                cell.openImage.isHidden = true
                cell.outerView.backgroundColor = .colorF8F6FF
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
        
        let outerView = UIView(frame: .init(x: 20, y: 0, width: tableView.bounds.width - 40, height: 20))
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
       
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if myRoutines.count > 0 {
            return selectedRoutines[section] == true ? 19 : 17
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if myRoutines.count > 0 && indexPath.row == 0 {
            if !selectedRoutines[indexPath.section] {
                if preSelectedIndex >= 0 {
                    selectedRoutines[preSelectedIndex] = false
                    tableView.reloadSections([preSelectedIndex], with: .none)
                }
                
                preSelectedIndex = indexPath.section
            }
            
            selectedRoutines[indexPath.section] = !selectedRoutines[indexPath.section]
            
            tableView.reloadSections([indexPath.section], with: .none)
        }
    }
    
    @objc func routineCellTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let footerView = gestureRecognizer.view else { return }
        let section = footerView.tag

        if !selectedRoutines[section] {
            if preSelectedIndex >= 0 {
                selectedRoutines[preSelectedIndex] = false
                routineTableView.reloadSections([preSelectedIndex], with: .none)
            }
            
            preSelectedIndex = section
        }

        selectedRoutines[section] = !selectedRoutines[section]
        
        routineTableView.reloadSections([section], with: .none)
    }
}
