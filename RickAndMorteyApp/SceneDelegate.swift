//
//  SceneDelegate.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 03.09.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let userDefaultsManager = UserDefaults.standard


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let rootVC = storyboard.instantiateViewController (withIdentifier: "navi") as! UITabBarController
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        let loginsVC = self.storyboard.instantiateViewController(identifier: "LoginsViewController") as! LoginViewController
        loginsVC.modalPresentationStyle = .fullScreen
        rootVC.present(loginsVC, animated: false)

        if self.userDefaultsManager.object(forKey: "Greeting") == nil {
            let greetingVC = self.storyboard.instantiateViewController(identifier: "pageViewController") as! PageViewController
                loginsVC.present(greetingVC, animated: true)
        }
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
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        NotificationsManager.shared.scheduleNotifitacons()
        CoreDataManager.shared.saveContext()
    }


}

