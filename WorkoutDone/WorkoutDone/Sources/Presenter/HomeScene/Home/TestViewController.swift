//
//  TestViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/05.
//

import UIKit

class TestViewController: BaseViewController {
    private let calendarView = CalendarView().then {
        $0.backgroundColor = .color7442FF
        $0.layer.cornerRadius = 15
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(calendarView)
        setLayout()
    }
    
    func setLayout() {
        calendarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(333)
        }
    }
}
