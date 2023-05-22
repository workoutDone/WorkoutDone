//
//  TabBarController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/05.
//

import UIKit

class TabBarController : UITabBarController {
    
    private lazy var duringWorkoutViewController : DuringWorkoutViewController = {
       let duringWorkoutViewController = DuringWorkoutViewController()
        duringWorkoutViewController.view.tag = 992
        duringWorkoutViewController.expandedViewHeight = view.frame.height
        return duringWorkoutViewController
    }()
    
    
    let homeTab = UINavigationController(rootViewController: HomeViewController())
    let routineTab = UINavigationController(rootViewController: RoutineViewController())
    let myRecordTab = UINavigationController(rootViewController: MyRecordViewController())
    
    let homeTabBarItem = UITabBarItem(title: "오늘의 운동", image: UIImage(named: "homeIcon"), tag: 0)
    let routineTabBarItem = UITabBarItem(title: "운동 루틴", image: UIImage(named: "routineIcon"), tag: 1)
    let myRecordTabBarItem = UITabBarItem(title: "나의 기록", image: UIImage(named: "myRecordIcon"), tag: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        view.insertSubview(duringWorkoutViewController.view, at: 1)
        
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
        if let tabBarController = self.tabBarController {
            let currentTabIndex = tabBarController.selectedIndex
            print("현재 선택된 탭의 인덱스: \(currentTabIndex)")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(showDuringWorkoutViewController(_:)), name: NSNotification.Name(duringWorkoutVcVisibility), object: nil)
    }
    @objc func showDuringWorkoutViewController(_ notification: Notification) {
        print("showDuringWorkoutViewController")
        self.tabBar.isHidden.toggle()
    }
}

extension TabBarController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if let tabBarController = self.tabBarController {
            if let currentViewController = tabBarController.selectedViewController {
                // 현재 화면에 나타난 뷰 컨트롤러를 사용하여 원하는 작업 수행
                print("현재 화면에 나타난 뷰 컨트롤러: \(currentViewController)")
            }
        }
        if let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            if selectedIndex == 0 {
                duringWorkoutViewController.view.isHidden = false
                duringWorkoutViewController.view.isUserInteractionEnabled = true
            }
            else {
                duringWorkoutViewController.view.isHidden = true
                duringWorkoutViewController.view.isUserInteractionEnabled = false
            }
        }
    }
}
