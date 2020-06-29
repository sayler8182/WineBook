//
//  LoginWithEmailPasswordRouter.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsInjector
import UIKit

// MARK: LoginWithEmailPasswordRoutingLogic
protocol LoginWithEmailPasswordRoutingLogic {
    func routeToDashboard()
}

// MARK: LoginWithEmailPasswordDataPassing
protocol LoginWithEmailPasswordDataPassing {
    var dataStore: LoginWithEmailPasswordDataStore! { get }
}

// MARK: LoginWithEmailPasswordRouter
class LoginWithEmailPasswordRouter: LoginWithEmailPasswordRoutingLogic, LoginWithEmailPasswordDataPassing {
    weak var controller: LoginWithEmailPasswordViewController!
    var dataStore: LoginWithEmailPasswordDataStore!
    private let injector: Injector = Forms.injector
    
    func routeToDashboard() {
        let destinationVC: DashboardViewController = self.injector.resolve()
        var destinationDS: DashboardDataStore = destinationVC.router.dataStore
        self.passDataToDashboard(source: self.dataStore, destination: &destinationDS)
        self.navigateToDashboard(destination: destinationVC)
    }
    
    private func passDataToDashboard(source: LoginWithEmailPasswordDataStore,
                                     destination: inout DashboardDataStore) { }
    
    private func navigateToDashboard(destination: DashboardViewController) {
        self.controller.window?.show(destination, animated: true)
    }
}
