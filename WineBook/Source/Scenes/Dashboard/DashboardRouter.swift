//
//  DashboardRouter.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsInjector
import UIKit

// MARK: DashboardRoutingLogic
protocol DashboardRoutingLogic {
    func homePath() -> UIViewController
    func discountPath() -> UIViewController
    func infoPath() -> UIViewController
}

// MARK: DashboardDataPassing
protocol DashboardDataPassing {
    var dataStore: DashboardDataStore! { get }
}

// MARK: DashboardRouter
class DashboardRouter: DashboardRoutingLogic, DashboardDataPassing {
    weak var controller: DashboardViewController!
    var dataStore: DashboardDataStore!
    private let injector: Injector = Forms.injector
    
    func homePath() -> UIViewController {
        let destinationVC: HomeViewController = self.injector.resolve()
        var destinationDS: HomeDataStore = destinationVC.router.dataStore
        self.passDataToHome(source: self.dataStore, destination: &destinationDS)
        return self.pathToHome(destination: destinationVC)
    }
    
    private func passDataToHome(source: DashboardDataStore,
                                destination: inout HomeDataStore) { }
    
    private func pathToHome(destination: HomeViewController) -> UIViewController {
        let navigation = FormsNavigationController()
            .with(controller: destination)
        return navigation
    }
    
    func discountPath() -> UIViewController {
        let destinationVC: DiscountViewController = self.injector.resolve()
        var destinationDS: DiscountDataStore = destinationVC.router.dataStore
        self.passDataToDiscount(source: self.dataStore, destination: &destinationDS)
        return self.pathToDiscount(destination: destinationVC)
    }
    
    private func passDataToDiscount(source: DashboardDataStore,
                                    destination: inout DiscountDataStore) { }
    
    private func pathToDiscount(destination: DiscountViewController) -> UIViewController {
        let navigation = FormsNavigationController()
            .with(controller: destination)
        return navigation
    }
    
    func infoPath() -> UIViewController {
        let destinationVC: InfoViewController = self.injector.resolve()
        var destinationDS: InfoDataStore = destinationVC.router.dataStore
        self.passDataToInfo(source: self.dataStore, destination: &destinationDS)
        return self.pathToInfo(destination: destinationVC)
    }
    
    private func passDataToInfo(source: DashboardDataStore,
                                destination: inout InfoDataStore) { }
    
    private func pathToInfo(destination: InfoViewController) -> UIViewController {
        let navigation = FormsNavigationController()
            .with(controller: destination)
        return navigation
    }
}
