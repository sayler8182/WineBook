//
//  HomeRouter.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsInjector
import UIKit

// MARK: HomeRoutingLogic
protocol HomeRoutingLogic {
    func routeToProductDetails()
}

// MARK: HomeDataPassing
protocol HomeDataPassing {
    var dataStore: HomeDataStore! { get }
}

// MARK: HomeRouter
class HomeRouter: HomeRoutingLogic, HomeDataPassing {
    weak var controller: HomeViewController!
    var dataStore: HomeDataStore!
    private let injector: Injector = Forms.injector
    
    func routeToProductDetails() {
        let destinationVC: ProductDetailsViewController = self.injector.resolve()
        var destinationDS: ProductDetailsDataStore = destinationVC.router.dataStore
        self.passDataToProductDetails(source: self.dataStore, destination: &destinationDS)
        self.navigateToProductDetails(destination: destinationVC)
    }
    
    private func passDataToProductDetails(source: HomeDataStore,
                                          destination: inout ProductDetailsDataStore) {
        destination.productId = source.productId
    }
    
    private func navigateToProductDetails(destination: ProductDetailsViewController) {
        self.controller.navigationController?.pushViewController(destination, animated: true)
    }
}
