//
//  LoginRouter.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsInjector
import UIKit

// MARK: LoginRoutingLogic
protocol LoginRoutingLogic {
    func routeToDashboard()
    func routeToLoginWithEmail()
}

// MARK: LoginDataPassing
protocol LoginDataPassing {
    var dataStore: LoginDataStore! { get }
}

// MARK: LoginRouter
class LoginRouter: LoginRoutingLogic, LoginDataPassing {
    weak var controller: LoginViewController!
    var dataStore: LoginDataStore!
    private let injector: Injector = Forms.injector
    
    func routeToDashboard() {
        let destinationVC: DashboardViewController = self.injector.resolve()
        var destinationDS: DashboardDataStore = destinationVC.router.dataStore
        self.passDataToDashboard(source: self.dataStore, destination: &destinationDS)
        self.navigateToDashboard(destination: destinationVC)
    }
    
    private func passDataToDashboard(source: LoginDataStore,
                                     destination: inout DashboardDataStore) { }
    
    private func navigateToDashboard(destination: DashboardViewController) {
        self.controller.window?.show(destination, animated: true)
    }
    
    func routeToLoginWithEmail() {
        let destinationVC: LoginWithEmailViewController = self.injector.resolve()
        var destinationDS: LoginWithEmailDataStore = destinationVC.router.dataStore
        self.passDataToLoginWithEmail(source: self.dataStore, destination: &destinationDS)
        self.navigateToLoginWithEmail(destination: destinationVC)
    }
    
    private func passDataToLoginWithEmail(source: LoginDataStore,
                                          destination: inout LoginWithEmailDataStore) { }
    
    private func navigateToLoginWithEmail(destination: LoginWithEmailViewController) {
        let navigation = TransitionNavigationViewController()
            .with(controller: destination)
        navigation.modalPresentationStyle = .fullScreen
        self.controller.present(navigation, animated: true, completion: nil)
    }
}
