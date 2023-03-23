//
//  TestViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/05.
//

import UIKit

class TestViewController: BaseViewController {
    private let calendarView = CalendarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(calendarView)
        setLayout()
    }
    
    func setLayout() {
        calendarView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
