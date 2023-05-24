//
//  RoutineAlertViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/23.
//

import UIKit

protocol RoutineAlertDelegate: AnyObject {
    func routineDeleteButtonTapped()
}

class RoutineAlertViewController: BaseViewController {
    
    // MARK: - PROPERTIES
    private var deleteAlertView = DeleteAlertView(deleteButtonTitle: "네 그만둘게요", title: "루틴 작성을 그만둘까요?", hasSubTitle: true, subTitle: "작성하던 내용은 저장되지 않아요!")
    
    weak var delegate: RoutineAlertDelegate?
    
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
        delegate?.routineDeleteButtonTapped()
    }
}
