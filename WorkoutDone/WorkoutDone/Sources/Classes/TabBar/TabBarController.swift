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
    
    let homeTabBarItem = UITabBarItem(title: "오늘의 운동", image: UIImage(named: "homeIcon"), tag: 0)
    let routineTabBarItem = UITabBarItem(title: "운동 루틴", image: UIImage(named: "routineIcon"), tag: 1)
    let myRecordTabBarItem = UITabBarItem(title: "나의 기록", image: UIImage(named: "myRecordIcon"), tag: 2)
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
        
        tabBar.tintColor = .color000000
        tabBar.unselectedItemTintColor = .lightGray
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        //Todo: - 텝바 색상, 탭바 이미지, 텍스트 정하기
    }
}
