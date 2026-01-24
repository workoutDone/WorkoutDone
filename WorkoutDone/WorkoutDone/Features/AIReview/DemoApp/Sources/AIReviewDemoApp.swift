import UIKit

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // SceneDelegate가 모든 화면을 담당
        return true
    }
}

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)

        let rootViewController =
            AIReviewDemoRootBuilder().makeRootViewController()

        window.rootViewController =
            UINavigationController(rootViewController: rootViewController)

        self.window = window
        window.makeKeyAndVisible()
    }
}
