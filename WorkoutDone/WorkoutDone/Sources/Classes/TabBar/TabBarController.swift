//
//  TabBarController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/05.
//

import UIKit

class TabBarController : UITabBarController {
    let homeTab = UINavigationController(rootViewController: HomeViewController())
    let routineTab = UINavigationController(rootViewController: RoutineViewController())
    let myRecordTab = UINavigationController(rootViewController: MyRecordViewController())
    let homeTabBarItem = UITabBarItem(title: "오늘의 운동", image: UIImage(systemName: "mic"), tag: 0)
    let routineTabBarItem = UITabBarItem(title: "운동 루틴", image: UIImage(systemName: "mic"), tag: 1)
    let myRecordTabBarItem = UITabBarItem(title: "나의 기록", image: UIImage(systemName: "mic"), tag: 2)
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTab.tabBarItem = homeTabBarItem
        routineTab.tabBarItem = routineTabBarItem
        myRecordTab.tabBarItem = myRecordTabBarItem
        viewControllers = [homeTab, routineTab, myRecordTab]
        tabBar.isTranslucent = false
        tabBar.barTintColor = .colorFFFFFF
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor.blue
        
        tabBar.tintColor = .color000000
        tabBar.unselectedItemTintColor = .lightGray
        
        //Todo: - 텝바 색상, 탭바 이미지, 텍스트 정하기
    }
}
