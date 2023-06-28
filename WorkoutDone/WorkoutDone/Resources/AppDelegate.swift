//
//  AppDelegate.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/03.
//

import UIKit
import RealmSwift
import NotificationCenter

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

//    func applicationDidEnterBackground(_ application: UIApplication) {
//        var window: UIWindow?
//        if let navigationController = window?.rootViewController as? UINavigationController {
//            if let duringWorkoutViewController = navigationController.viewControllers.first as? DuringWorkoutViewController {
//                // 데이터에 접근하여 사용할 수 있습니다.
//                let count = duringWorkoutViewController.count
//                print(count, "제발")
//                UserDefaults.standard.setValue(count, forKey: "existingCountData")
//                // 데이터 사용
//            }
//        }
//    }
}
