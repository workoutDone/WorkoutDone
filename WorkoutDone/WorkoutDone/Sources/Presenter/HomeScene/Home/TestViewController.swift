//
//  TestViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/05.
//

import UIKit

class TestViewController: BaseViewController {
    private let calendarView = CalendarView()
    
    private let toggleButton = GridToggleButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(calendarView)
        view.addSubview(toggleButton)
        setLayout()
        
        toggleButton.addTarget(self, action: #selector(gridToggleButtonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        calendarView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        toggleButton.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-100)
        }
    }
    
    
    @objc func gridToggleButtonTapped(_ sender: UIButton) {
        print("클릭2")
    }
}
