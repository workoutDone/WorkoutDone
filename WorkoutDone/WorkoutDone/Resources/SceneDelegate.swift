//
//  SceneDelegate.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/03.
//

import UIKit
import RealmSwift



class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        setRootViewController(scene)
        
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        guard let start = UserDefaults.standard.object(forKey: "sceneDidEnterBackground") as? Date else { return }
        let interval = Int(Date().timeIntervalSince(start))
        NotificationCenter.default.post(name: NSNotification.Name("sceneWillEnterForeground"), object: nil,userInfo: ["time" : interval])
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        NotificationCenter.default.post(name: NSNotification.Name("sceneDidEnterBackground"), object: nil)
                UserDefaults.standard.setValue(Date(), forKey: "sceneDidEnterBackground")
    }
}

extension SceneDelegate {
    private func setRootViewController(_ scene: UIScene) {
        let manager = UserDefaultsManager.shared
        ///온보딩 마쳤을 때
        if manager.hasOnboarded {
            ///운동 중일때
            if manager.isWorkout {
                let duringWorkoutViewController = DuringWorkoutViewController()
                setRootViewController(scene, viewController: UINavigationController(rootViewController: duringWorkoutViewController))
            }
            else {
                ///홈 화면
                setRootViewController(scene, viewController: TabBarController())
            }
        }
        else {
            ///온보딩을 마치지 못했을 때
            setRootViewController(scene, viewController: OnboardingViewController())
        }
    }
    
    private func setRootViewController(_ scene: UIScene, viewController: UIViewController) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
}


