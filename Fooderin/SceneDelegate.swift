//
//  SceneDelegate.swift
//  Fooderin
//
//  Created by Алексей Павленко on 19.09.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let visualEffect = UIVisualEffectView(effect: blurEffect)
        visualEffect.alpha = 1
        return visualEffect
    }()
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let onboardingScreenWasShown = UserDefaults.standard.bool(forKey: UserDefaults.Keys.onboardingScreenWasShown)
        let viewController: UIViewController
        if onboardingScreenWasShown {
            let homeController = HomeViewController.instantiate()
            viewController = UINavigationController(rootViewController: homeController)
        } else {
            viewController = OnboardingViewController.instantiate()
        }
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        guard let _ = window?.rootViewController as? UINavigationController else { return }
        blurView.removeFromSuperview()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        guard let navVC = window?.rootViewController as? UINavigationController else { return }
        blurView.frame = navVC.view.bounds
        navVC.view.addSubview(blurView)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

