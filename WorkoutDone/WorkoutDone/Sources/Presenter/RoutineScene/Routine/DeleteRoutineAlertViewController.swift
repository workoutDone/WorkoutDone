//
//  DeleteRoutineAlertViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/06/28.
//

import UIKit

class DeleteRoutineAlertViewController : BaseViewController {
    
    // MARK: - PROPERTIES
    private var deleteAlertView = DeleteAlertView(deleteButtonTitle: "네, 지울게요", title: "정말로 이 루틴을\n삭제할까요?", hasSubTitle: false, subTitle: "")
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setComponents() {
        super.setComponents()
        
        view.backgroundColor = .color3C3C43.withAlphaComponent(0.6)
        view = deleteAlertView
    }
    
    // MARK: - ACTIONS
    override func actions() {
        deleteAlertView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        deleteAlertView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: false)
    }
    
    @objc func deleteButtonTapped() {
        dismiss(animated: false)
    }
}
