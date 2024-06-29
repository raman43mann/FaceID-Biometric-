//
//  SceneDelegate.swift
//  FaceIDSignin
//
//  Created by Ramanjeet Singh on 27/06/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var isBioMetricLogedIn : Bool{
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isBioMetricLogedIn")
        }
        get {
            return UserDefaults.standard.bool(forKey: "isBioMetricLogedIn")
        }
    }
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
  
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        self.setupLoginScreen()
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
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.blockAppFromAppleSignin()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}



extension SceneDelegate {
    func setupLoginScreen(){
        if isBioMetricLogedIn{
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            guard let viewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return }
            let navigationController = UINavigationController(rootViewController: viewController)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }else{
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            guard let viewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
            let navigationController = UINavigationController(rootViewController: viewController)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    }
    
    func blockAppFromAppleSignin(){
        if isBioMetricLogedIn{
            let biometricVC = BiometricAuthenticationPopupVC()
            biometricVC.modalPresentationStyle = .overFullScreen // Ensures blur covers the entire screen
            BiometricHelper.shared.topMostViewController()?.present(biometricVC, animated: true, completion: nil)
        }
    }
}
