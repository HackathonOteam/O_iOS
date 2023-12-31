import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
      
        //let registVC = RegistViewController()
        let tabbar = MainTabbarController()
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem.image = UIImage(named: "HomeOff")?.withRenderingMode(.alwaysOriginal)
        homeVC.tabBarItem.selectedImage = UIImage(named: "HomeOn")?.withRenderingMode(.alwaysOriginal)
        homeVC.tabBarItem.title = "홈"
        UserDefaults.standard.removeObject(forKey: "key")
        
        let dummyVC = UIViewController()
        dummyVC.view.tag = 400
    
        let calendarVC = UINavigationController(rootViewController: MonthCalendarViewController())
        calendarVC.tabBarItem.image = UIImage(named: "calendarOff")?.withRenderingMode(.alwaysOriginal)
        calendarVC.tabBarItem.selectedImage = UIImage(named: "calendarOn")?.withRenderingMode(.alwaysOriginal)
        calendarVC.tabBarItem.title = "이번 달 감정"
        
        tabbar.viewControllers = [homeVC, dummyVC, calendarVC]
        tabbar.tabBar.tintColor = .activeBlueColor
        tabbar.tabBar.unselectedItemTintColor = .subGrayColor
      
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

