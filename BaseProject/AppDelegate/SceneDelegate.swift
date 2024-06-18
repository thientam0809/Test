//
//  SceneDelegate.swift
//  BaseProject
//
//  Created by Nguyen Khanh Thien Tam on 10/06/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let vc = HomeViewController()
        let cacheRepository = CacheWorkoutImplementation()
        let repository = HomeRepositoryImplementation(cacheRepository: cacheRepository)
        let useCase = HomeUseCaseImplementation(repository: repository)
        vc.viewModel = HomeViewModel(useCase: useCase)
        let navi = UINavigationController(rootViewController: vc)
        
        window.rootViewController = navi
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }


}
