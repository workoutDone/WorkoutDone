//
//  EndWorkoutViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/06/08.
//

import UIKit

class EndWorkoutViewController : BaseViewController {
    // MARK: - PROPERTIES
    private var endWorkoutAlertView = EndWorkoutAlertView()
    
    // MARK: - LIFECYCLE
    override func loadView() {
        super.loadView()
        endWorkoutAlertView = EndWorkoutAlertView(frame: self.view.frame)
        view = endWorkoutAlertView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setComponents() {
        super.setComponents()
        endWorkoutAlertView = EndWorkoutAlertView(frame: self.view.frame)
        view = endWorkoutAlertView

    }
    
    // MARK: - ACTIONS
    override func actions() {
        endWorkoutAlertView.deleteAlertView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        endWorkoutAlertView.deleteAlertView.deleteButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    @objc func saveButtonTapped() {
//        dismiss(animated: true)
        let duringWorkoutResultViewController = DuringWorkoutResultViewController()
        let navigationController = UINavigationController(rootViewController: duringWorkoutResultViewController)
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}
// MARK: - EXTENSIONs
extension EndWorkoutViewController {
    
}
