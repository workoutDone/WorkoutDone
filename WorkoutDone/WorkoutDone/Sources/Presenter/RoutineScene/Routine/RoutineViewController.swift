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
    var opend : Bool
}

struct CategoryData {
    var categoryName : String
    var training : String
}

class RoutineViewController : BaseViewController {
    var sampleData =
    [
        MyRoutineData(title: "오늘은 등 운동!", category: [CategoryData(categoryName: "어깨", training: "배틀 로프")], opend: false),
        MyRoutineData(title: "어깨 몸짱 가보자고", category: [CategoryData(categoryName: "어깨", training: "배틀 로프"), CategoryData(categoryName: "어깨", training: "클린 앤 저크"), CategoryData(categoryName: "어깨", training: "플란체")], opend: false),
        MyRoutineData(title: "바프를 향해 데일리루틴", category: [CategoryData(categoryName: "냠냠", training: "냠냠")], opend: false)
    ]
    
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
    }
    
    override func setupLayout() {
        view.addSubview(routineTableView)
        view.addSubview(createdButton)
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
        navigationController?.pushViewController(createRoutineVC, animated: false)
    }
}

extension RoutineViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sampleData.count == 0 ? 1 : sampleData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sampleData.count > 0 && sampleData[section].opend == true {
            return sampleData[section].category.count + 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if sampleData.count == 0 || section == 0 {
            return 0.1
        }
        return 14
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if sampleData.count == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "emptyRoutineCell", for: indexPath) as? EmptyRoutineCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            return cell
        }
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "routineCell", for: indexPath) as? RoutineCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.delegate = self
            cell.routineTitleLabel.text = sampleData[indexPath.section].title
            cell.editButton.isHidden = true
            
            cell.outerView.backgroundColor = .colorCCCCCC
            if sampleData[indexPath.section].opend {
                cell.editButton.isHidden = false
            }
            
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "routineDetailCell", for: indexPath) as? RoutineDetailCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        cell.bodyPartLabel.text = sampleData[indexPath.section].category[indexPath.row - 1].categoryName
        cell.weightTrainingLabel.text = sampleData[indexPath.section].category[indexPath.row - 1].training
        
        cell.outerView.backgroundColor = .colorCCCCCC

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sampleData.count == 0 {
            return tableView.frame.height
        }
        
        if indexPath.row == 0 {
            return sampleData[indexPath.section].opend == true ? 65 : 53
        }
        return 58
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        
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
       
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sampleData[section].opend == true ? 19 : 17
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if sampleData.count > 0 && indexPath.row == 0 {
            if !sampleData[indexPath.section].opend {
                if preSelectedIndex >= 0 {
                    sampleData[preSelectedIndex].opend = false
                    tableView.reloadSections([preSelectedIndex], with: .none)
                }
                
                preSelectedIndex = indexPath.section
            }
            
            sampleData[indexPath.section].opend = !sampleData[indexPath.section].opend
            tableView.reloadSections([indexPath.section], with: .none)
        }
    }
    
    @objc func routineCellTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let footerView = gestureRecognizer.view else { return }
        let section = footerView.tag

        if !sampleData[section].opend {
            if preSelectedIndex >= 0 {
                sampleData[preSelectedIndex].opend = false
                routineTableView.reloadSections([preSelectedIndex], with: .none)
            }
            
            preSelectedIndex = section
        }
        
        sampleData[section].opend = !sampleData[section].opend
        routineTableView.reloadSections([section], with: .none)
    }
}
