//
//  RegisterWithEmailRouter.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsInjector
import UIKit

// MARK: RegisterWithEmailRoutingLogic
protocol RegisterWithEmailRoutingLogic {
    func routeToDashboard()
}

// MARK: RegisterWithEmailDataPassing
protocol RegisterWithEmailDataPassing {
    var dataStore: RegisterWithEmailDataStore! { get }
}

// MARK: RegisterWithEmailRouter
class RegisterWithEmailRouter: RegisterWithEmailRoutingLogic, RegisterWithEmailDataPassing {
    weak var controller: RegisterWithEmailViewController!
    var dataStore: RegisterWithEmailDataStore!
    private let injector: Injector = Forms.injector
    
    func routeToDashboard() {
        let destinationVC: DashboardViewController = self.injector.resolve()
        var destinationDS: DashboardDataStore = destinationVC.router.dataStore
        self.passDataToDashboard(source: self.dataStore, destination: &destinationDS)
        self.navigateToDashboard(destination: destinationVC)
    }
    
    private func passDataToDashboard(source: RegisterWithEmailDataStore,
                                     destination: inout DashboardDataStore) { }
    
    private func navigateToDashboard(destination: DashboardViewController) {
        self.controller.window?.show(destination, animated: true)
    }
}
