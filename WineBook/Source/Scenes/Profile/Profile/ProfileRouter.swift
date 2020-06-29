//
//  ProfileRouter.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsInjector
import UIKit

// MARK: ProfileRoutingLogic
protocol ProfileRoutingLogic {
    func routeToLogin()
}

// MARK: ProfileDataPassing
protocol ProfileDataPassing {
    var dataStore: ProfileDataStore! { get }
}

// MARK: ProfileRouter
class ProfileRouter: ProfileRoutingLogic, ProfileDataPassing {
    weak var controller: ProfileViewController!
    var dataStore: ProfileDataStore!
    private let injector: Injector = Forms.injector
    
    func routeToLogin() {
        let destinationVC: LoginViewController = self.injector.resolve()
        var destinationDS: LoginDataStore = destinationVC.router.dataStore
        self.passDataToLogin(source: self.dataStore, destination: &destinationDS)
        self.navigateToLogin(destination: destinationVC)
    }
    
    private func passDataToLogin(source: ProfileDataStore,
                                 destination: inout LoginDataStore) { }
    
    private func navigateToLogin(destination: LoginViewController) {
        self.controller.window?.show(destination, animated: true)
    }
}
