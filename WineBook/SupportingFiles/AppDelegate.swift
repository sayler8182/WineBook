//
//  AppDelegate.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FBSDKCoreKit
import FirebaseCore
import Forms
import FormsAnalytics
import FormsDeveloperTools
import FormsHomeShortcuts
import FormsInjector
import FormsLogger
import FormsNotifications
import FormsPermissions
import FormsSocialKit
import GoogleSignIn
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    @OptionalInjected
    private var homeShortcuts: HomeShortcutsProtocol? // swiftlint:disable:this let_var_whitespace
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // DeveloperTools - Console
        Console.configure()
        
        // Forms
        Forms.configure(Injector.main, [
            NetworkAssembly(),
            ThemeAssembly(),
            ScenesAssembly()
        ])
        
        // Facebook
        ApplicationDelegate.initializeSDK(launchOptions)
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions)
        
        // Firebase
        FirebaseApp.configure()
        
        // GoogleSignIn
        GIDSignIn.sharedInstance().clientID = "49498117641-n1k6tau9bqbqigcb5ousck4el4sdompp.apps.googleusercontent.com"
        
        // Analytics
        Analytics.register([
            AnalyticsFirebaseProvider()
        ])
        
        // DeveloperTools
        DeveloperTools.configure(
            features: DeveloperFeatureKeys.allCases,
            featuresFlags: DeveloperFeatureFlagKeys.allCases,
            onSelect: DeveloperToolsManager.onSelect)
        
        // DeveloperTools - LifetimeTracker
        LifetimeTracker.configure()
        
        // HomeShortcuts
        self.homeShortcuts?.add(keys: [])
        self.homeShortcuts?.launch(launchOptions)
        
        // SocialKit
        SocialKit.configure()
        
        // Root
        if #available(iOS 13.0, *) {
        } else {
            let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = Injector.main.resolve(SplashViewController.self)
            self.window = window
            window.makeKeyAndVisible()
        }
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

// MARK: Shortcut Item
extension AppDelegate {
    func application(_ application: UIApplication,
                     performActionFor shortcutItem: UIApplicationShortcutItem,
                     completionHandler: @escaping (Bool) -> Void) {
        self.homeShortcuts?.launch(shortcutItem)
        completionHandler(true)
    }
}
