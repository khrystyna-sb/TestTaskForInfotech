//
//  SceneDelegate.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 29.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        // presenter pattern
        let cityListTableViewController = CityListTableViewController()
        navigationController.pushViewController(cityListTableViewController, animated: false)
    }
}

