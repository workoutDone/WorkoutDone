//
//  TabBarController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/05.
//

import UIKit

class TabBarController : UITabBarController {
    let homeTab = HomeViewController()
    let routineTab = RoutineViewController()
    let myRecordTab = MyRecordViewController()
    let homeTabBarItem = UITabBarItem(title: "오늘의 운동", image: UIImage(named: ""), tag: 0)
    let routineTabBarItem = UITabBarItem(title: "운동 루틴", image: UIImage(named: ""), tag: 1)
    let myRecordTabBarItem = UITabBarItem(title: "나의 기록", image: UIImage(named: ""), tag: 2)
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [homeTab, routineTab, myRecordTab]
        tabBar.isTranslucent = false
        tabBar.barTintColor = .purple
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.blue
        
        //Todo: - 텝바 색상, 탭바 이미지, 텍스트 정하기
    }
}
