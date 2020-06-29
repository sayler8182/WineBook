//
//  LoginWithEmailRouter.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsInjector
import UIKit

// MARK: LoginWithEmailRoutingLogic
protocol LoginWithEmailRoutingLogic {
    func routeToLoginWithEmailCode()
}

// MARK: LoginWithEmailDataPassing
protocol LoginWithEmailDataPassing {
    var dataStore: LoginWithEmailDataStore! { get }
}

// MARK: LoginWithEmailRouter
class LoginWithEmailRouter: LoginWithEmailRoutingLogic, LoginWithEmailDataPassing {
    weak var controller: LoginWithEmailViewController!
    var dataStore: LoginWithEmailDataStore!
    private let injector: Injector = Forms.injector

    func routeToLoginWithEmailCode() {
        let destinationVC: LoginWithEmailCodeViewController = self.injector.resolve()
        var destinationDS: LoginWithEmailCodeDataStore = destinationVC.router.dataStore
        self.passDataToLoginWithEmailCode(source: self.dataStore, destination: &destinationDS)
        self.navigateToLoginWithEmailCode(destination: destinationVC)
    }
    
    private func passDataToLoginWithEmailCode(source: LoginWithEmailDataStore,
                                              destination: inout LoginWithEmailCodeDataStore) {
        destination.model.email = source.model.email
    }
    
    private func navigateToLoginWithEmailCode(destination: LoginWithEmailCodeViewController) {
        self.controller.navigationController?.pushViewController(destination, animated: true)
    } 
}
