//
//  DuringEditRoutineViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/26.
//

import UIKit

class DuringEditRoutineViewController : BaseViewController {
    private var dummy = ExBodyPart.dummy()
    // MARK: - PROPERTIES
    private let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .colorFFFFFF
        $0.separatorStyle = .none
    }
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func setComponents() {
        super.setComponents()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DuringEditRoutineTableViewCell.self, forCellReuseIdentifier: DuringEditRoutineTableViewCell.identifier)
//        tableView.register(DuringEditRoutineHeaderCell.self, forHeaderFooterViewReuseIdentifier: DuringEditRoutineHeaderCell.headerViewID)
//        tableView.register(DuringEditRoutineFooterCell.self, forHeaderFooterViewReuseIdentifier: DuringEditRoutineFooterCell.footerViewID)
    }
    override func setupLayout() {
        super.setupLayout()
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(14)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - ACTIONS
    override func actions() {
    }
}
// MARK: - EXTENSIONs
extension DuringEditRoutineViewController : UITableViewDelegate, UITableViewDataSource, DuringEditFooterDelegate {
    func addWorkoutButtonTapped() {
        print("?????????ddd")
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제하기"
    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            dummy[indexPath.section].weightTraining.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return dummy.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummy[section].weightTraining.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DuringEditRoutineTableViewCell.identifier, for: indexPath) as? DuringEditRoutineTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.workoutCategoryLabel.text = dummy[indexPath.section].name
        cell.workoutTitleLabel.text = dummy[indexPath.section].weightTraining[indexPath.row].name
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//            return 46
//        }
//        else {
//            return 0
//        }
//    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if section == dummy.count - 1 {
//            return 66
//        }
//        else {
//            return 0
//        }
//    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DuringEditRoutineHeaderCell.headerViewID) as? DuringEditRoutineHeaderCell else { return  nil }
//        return headerView
//
//    }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DuringEditRoutineFooterCell.footerViewID) as? DuringEditRoutineFooterCell else { return  nil }
//        footerView.delegate = self
//        return footerView
//    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 7
    }
    
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
////        let movedItem = dataSource[sourceIndexPath.row] // 이동할 아이템
//        let movedItem = dummy[sourceIndexPath.section].weightTraining[sourceIndexPath.row]
//        dummy[sourceIndexPath.section].weightTraining.remove(at: sourceIndexPath.row) // 이동할 아이템을 원래 위치에서 제거
//        dummy.insert(contentsOf: movedItem, at: dummy[destinationIndexPath.section].weightTraining[destinationIndexPath.row]) // 이동할 아이템을 새로운 위치에 삽입
//    }

    
}

