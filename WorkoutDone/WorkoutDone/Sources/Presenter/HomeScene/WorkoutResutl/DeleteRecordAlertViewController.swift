//
//  DeleteRecordAlertViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/13.
//

import UIKit
import SnapKit
import Then

class DeleteRecordAlertViewController : BaseViewController {
    // MARK: - PROPERTIES
    private var deleteRecordAlertView = DeleteRecordAlertView()
    
    
    // MARK: - LIFECYCLE
    override func loadView() {
        super.loadView()
        deleteRecordAlertView = DeleteRecordAlertView(frame: self.view.frame)
        view = deleteRecordAlertView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setComponents() {
        super.setComponents()
        deleteRecordAlertView = DeleteRecordAlertView(frame: self.view.frame)
        view = deleteRecordAlertView

    }
    
    // MARK: - ACTIONS
    override func actions() {
        deleteRecordAlertView.deleteAlertView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        deleteRecordAlertView.deleteAlertView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    @objc func deleteButtonTapped() {
        
    }
}
// MARK: - EXTENSIONs
extension DeleteRecordAlertViewController {
    
}

