//
//  LoginWithEmailCodeRouter.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsInjector
import UIKit

// MARK: LoginWithEmailCodeRoutingLogic
protocol LoginWithEmailCodeRoutingLogic {
    func routeToLoginWithEmailPassword()
    func routeToRegisterWithEmail()
}

// MARK: LoginWithEmailCodeDataPassing
protocol LoginWithEmailCodeDataPassing {
    var dataStore: LoginWithEmailCodeDataStore! { get }
}

// MARK: LoginWithEmailCodeRouter
class LoginWithEmailCodeRouter: LoginWithEmailCodeRoutingLogic, LoginWithEmailCodeDataPassing {
    weak var controller: LoginWithEmailCodeViewController!
    var dataStore: LoginWithEmailCodeDataStore!
    private let injector: Injector = Forms.injector
    
    func routeToLoginWithEmailPassword() {
        let destinationVC: LoginWithEmailPasswordViewController = self.injector.resolve()
        var destinationDS: LoginWithEmailPasswordDataStore = destinationVC.router.dataStore
        self.passDataToLoginWithEmailPassword(source: self.dataStore, destination: &destinationDS)
        self.navigateToLoginWithEmailPassword(destination: destinationVC)
    }
    
    private func passDataToLoginWithEmailPassword(source: LoginWithEmailCodeDataStore,
                                                  destination: inout LoginWithEmailPasswordDataStore) {
        destination.model.email = source.model.email
        destination.model.code = source.model.code
    }
    
    private func navigateToLoginWithEmailPassword(destination: LoginWithEmailPasswordViewController) {
        self.controller.navigationController?.pushViewController(destination, animated: true)
    }
    
    func routeToRegisterWithEmail() {
        let destinationVC: RegisterWithEmailViewController = self.injector.resolve()
        var destinationDS: RegisterWithEmailDataStore = destinationVC.router.dataStore
        self.passDataToRegisterWithEmail(source: self.dataStore, destination: &destinationDS)
        self.navigateToRegisterWithEmail(destination: destinationVC)
    }
    
    private func passDataToRegisterWithEmail(source: LoginWithEmailCodeDataStore,
                                             destination: inout RegisterWithEmailDataStore) {
        destination.model.email = source.model.email
        destination.model.code = source.model.code
    }
    
    private func navigateToRegisterWithEmail(destination: RegisterWithEmailViewController) {
        self.controller.navigationController?.pushViewController(destination, animated: true)
    } 
}
