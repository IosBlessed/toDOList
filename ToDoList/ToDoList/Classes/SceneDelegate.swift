//
//  SceneDelegate.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let taskViewController = TaskDisplayBuilder.shared.buildTaskDisplay()
        let taskNavigationController = UINavigationController(
            rootViewController: taskViewController
        )
        let launchScreen = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        launchScreen?.view.backgroundColor = DesignedSystemColors.launchScreen
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            window.rootViewController = taskNavigationController
        }
        window.rootViewController = launchScreen
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataStack.shared.saveContext()
    }
}
