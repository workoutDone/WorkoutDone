//
//  DuringSetViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/26.
//

import UIKit

class DuringSetViewController : BaseViewController {
    
    var firstArrayIndex = 0
    var secondArrayIndex = 0
    
    
    private var dummy = ExBodyPart.dummy()
    // MARK: - PROPERTIES
    
    private let tableBackView = UIView().then {
        $0.backgroundColor = .colorF8F6FF
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 15
        $0.layer.borderColor = UIColor.colorE6E0FF.cgColor
    }
    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .colorF8F6FF
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 15
        $0.layer.borderColor = UIColor.colorE6E0FF.cgColor
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
        tableView.register(DuringSetTableViewCell.self, forCellReuseIdentifier: DuringSetTableViewCell.identifier)
        tableView.register(DuringSetFooterCell.self, forHeaderFooterViewReuseIdentifier: DuringSetFooterCell.footerViewID)
    }
    override func setupLayout() {
        super.setupLayout()
        view.addSubviews(tableView)
    }
    override func setupConstraints() {
        super.setupConstraints()
        tableView.snp.makeConstraints {
//            $0.edges.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalToSuperview().inset(29)
            $0.bottom.equalToSuperview().inset(14)
            $0.leading.trailing.equalToSuperview().inset(26)
        }
    }
    
    // MARK: - ACTIONS
    override func actions() {
        super.actions()
    }
}
// MARK: - EXTENSIONs

extension DuringSetViewController : UITableViewDelegate, UITableViewDataSource, DuringSetFooterDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dummy.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == firstArrayIndex {
            return 1
        }
        else {
            return 0
        }
//        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DuringSetTableViewCell.identifier, for: indexPath) as? DuringSetTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DuringSetFooterCell.footerViewID) as? DuringSetFooterCell else { return  nil }
        if section == dummy.count - 1 {
            footerView.delegate = self
            return footerView
        }
        else {
            return nil
        }
    }
    func addWorkoutButtonTapped() {
        print("?????????????????")
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let inputWorkoutDataViewController = InputWorkoutDataViewController()
        inputWorkoutDataViewController.modalTransitionStyle = .crossDissolve
        inputWorkoutDataViewController.modalPresentationStyle = .overFullScreen
        present(inputWorkoutDataViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 78
        }
        else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == dummy.count - 1 {
            return 66
        }
        else {
            return 0
        }
    }
}

//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.section == 0 {
//            cell.backgroundColor = .red
//            cell.layer.cornerRadius = 10
//        }
//    }
