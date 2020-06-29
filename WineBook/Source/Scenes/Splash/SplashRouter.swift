//
//  SplashRouter.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsInjector
import UIKit

// MARK: SplashRoutingLogic
protocol SplashRoutingLogic {
    func routeToLogin()
    func routeToDashboard()
}

// MARK: SplashDataPassing
protocol SplashDataPassing {
    var dataStore: SplashDataStore! { get }
}

// MARK: SplashRouter
class SplashRouter: SplashRoutingLogic, SplashDataPassing {
    weak var controller: SplashViewController!
    var dataStore: SplashDataStore!
    private let injector: Injector = Forms.injector
    
    func routeToLogin() {
        let destinationVC: LoginViewController = self.injector.resolve()
        var destinationDS: LoginDataStore = destinationVC.router.dataStore
        self.passDataToLogin(source: self.dataStore, destination: &destinationDS)
        self.navigateToLogin(destination: destinationVC)
    }
    
    private func passDataToLogin(source: SplashDataStore,
                                 destination: inout LoginDataStore) { }
    
    private func navigateToLogin(destination: LoginViewController) {
        self.controller.window?.show(destination, animated: true)
    }
    
    func routeToDashboard() {
        let destinationVC: DashboardViewController = self.injector.resolve()
        var destinationDS: DashboardDataStore = destinationVC.router.dataStore
        self.passDataToDashboard(source: self.dataStore, destination: &destinationDS)
        self.navigateToDashboard(destination: destinationVC)
    }
    
    private func passDataToDashboard(source: SplashDataStore,
                                     destination: inout DashboardDataStore) { }
    
    private func navigateToDashboard(destination: DashboardViewController) {
        self.controller.window?.show(destination, animated: true)
    }
}
