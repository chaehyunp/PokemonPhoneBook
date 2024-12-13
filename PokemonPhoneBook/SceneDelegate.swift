//
//  SceneDelegate.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/9/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    // composition root
    lazy var navigationViewController = UINavigationController()
    lazy var repository = CoreDataRepository(modelName: "PokemonPhoneBook")

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let list = ListViewController(coreDataRepository: repository)
        list.navigationItem.title = "친구 목록"
        list.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "추가",
            style: .plain,
            target: self,
            action: #selector(addContact)
        )
        window.rootViewController = navigationViewController
        window.makeKeyAndVisible()
        navigationViewController.setViewControllers([list], animated: false)
        self.window = window
    }
    
    // Navigation -> List
    
    // MARK: - Helpers
    
    @objc private func addContact() {
        let phoneBookViewController = PhoneBookViewController(
            coreDataRepository: repository,
            mode: .write
        )
        navigationViewController.pushViewController(phoneBookViewController, animated: true)
    }
}

