//
//  SceneDelegate.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FBSDKCoreKit
import Forms
import FormsHomeShortcuts
import FormsInjector
import UIKit

// MARK: SceneDelegate
@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    @OptionalInjected
    private var homeShortcuts: HomeShortcutsProtocol? // swiftlint:disable:this let_var_whitespace
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // HomeShortcuts
        self.homeShortcuts?.launch(connectionOptions.shortcutItem)
        
        // Root
        let window: UIWindow = UIWindow(windowScene: windowScene)
        Theme.setUserInterfaceStyle(window.traitCollection.userInterfaceStyle)
        window.rootViewController = Injector.main.resolve(SplashViewController.self)
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url: URL = URLContexts.first?.url else { return }
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation])
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        guard let window: UIWindow = self.window else { return }
        Theme.setUserInterfaceStyle(window.traitCollection.userInterfaceStyle)
    }
    
    func windowScene(_ windowScene: UIWindowScene,
                     didUpdate previousCoordinateSpace: UICoordinateSpace,
                     interfaceOrientation previousInterfaceOrientation: UIInterfaceOrientation,
                     traitCollection previousTraitCollection: UITraitCollection) {
        Theme.setUserInterfaceStyle(windowScene.traitCollection.userInterfaceStyle)
    }
}

// MARK: Shortcut Item
@available(iOS 13.0, *)
extension SceneDelegate {
    func windowScene(_ windowScene: UIWindowScene,
                     performActionFor shortcutItem: UIApplicationShortcutItem,
                     completionHandler: @escaping (Bool) -> Void) {
        self.homeShortcuts?.launch(shortcutItem)
        completionHandler(true)
    }
}
