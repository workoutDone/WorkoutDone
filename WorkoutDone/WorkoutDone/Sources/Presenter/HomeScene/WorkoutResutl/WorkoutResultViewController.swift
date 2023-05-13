//
//  WorkoutResultViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/13.
//

import UIKit
import SnapKit
import Then


class WorkoutResultViewController : BaseViewController {
    // MARK: - PROPERTIES
    private let deleteRecordButton = UIButton().then {
        $0.setTitle("기록 삭제", for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(.semiBold, size: 16)
        $0.setTitleColor(UIColor.colorF54968, for: .normal)
        $0.backgroundColor = UIColor.colorFFEDF0
        $0.layer.cornerRadius = 5
    }
    
    // MARK: - LIFECYCLE
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
            hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setComponents() {
        view.backgroundColor = .colorFFFFFF
        navigationItem.title = "나의 기록"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.color121212]
        navigationController?.isNavigationBarHidden = false
        let barButton = UIBarButtonItem()
        barButton.customView = deleteRecordButton
        navigationItem.rightBarButtonItem = barButton
    }
    override func setupConstraints() {
        deleteRecordButton.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(80)
        }
    }
    override func actions() {
        deleteRecordButton.addTarget(self, action: #selector(deleteRecordButtonTapped), for: .touchUpInside)
    }
    @objc func deleteRecordButtonTapped() {
        
    }
    
    // MARK: - ACTIONS
}
// MARK: - EXTENSIONs
extension WorkoutResultViewController {
    
}

