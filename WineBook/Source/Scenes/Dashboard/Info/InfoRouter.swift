//
//  InfoRouter.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsInjector
import UIKit

// MARK: InfoRoutingLogic
protocol InfoRoutingLogic {
    func routeToProfile()
    func routeToPurchases()
    func routeToAboutUs()
    func routeToContact()
}

// MARK: InfoDataPassing
protocol InfoDataPassing {
    var dataStore: InfoDataStore! { get }
}

// MARK: InfoRouter
class InfoRouter: InfoRoutingLogic, InfoDataPassing {
    weak var controller: InfoViewController!
    var dataStore: InfoDataStore!
    private let injector: Injector = Forms.injector
    
    func routeToProfile() {
        let destinationVC: ProfileViewController = self.injector.resolve()
        var destinationDS: ProfileDataStore = destinationVC.router.dataStore
        self.passDataToProfile(source: self.dataStore, destination: &destinationDS)
        self.navigateToProfile(destination: destinationVC)
    }
    
    private func passDataToProfile(source: InfoDataStore,
                                   destination: inout ProfileDataStore) { }
    
    private func navigateToProfile(destination: ProfileViewController) {
        let navigation = TransitionNavigationViewController()
            .with(controller: destination)
        navigation.modalPresentationStyle = .fullScreen
        self.controller.present(navigation, animated: true, completion: nil)
    }
    
    func routeToPurchases() {
        let destinationVC: PurchasesViewController = self.injector.resolve()
        var destinationDS: PurchasesDataStore = destinationVC.router.dataStore
        self.passDataToPurchases(source: self.dataStore, destination: &destinationDS)
        self.navigateToPurchases(destination: destinationVC)
    }
    
    private func passDataToPurchases(source: InfoDataStore,
                                     destination: inout PurchasesDataStore) { }
    
    private func navigateToPurchases(destination: PurchasesViewController) {
        let navigation = TransitionNavigationViewController()
            .with(controller: destination)
        navigation.modalPresentationStyle = .fullScreen
        self.controller.present(navigation, animated: true, completion: nil)
    }
    
    func routeToAboutUs() {
        let destinationVC: AboutUsViewController = self.injector.resolve()
        var destinationDS: AboutUsDataStore = destinationVC.router.dataStore
        self.passDataToAboutUs(source: self.dataStore, destination: &destinationDS)
        self.navigateToAboutUs(destination: destinationVC)
    }
    
    private func passDataToAboutUs(source: InfoDataStore,
                                   destination: inout AboutUsDataStore) { }
    
    private func navigateToAboutUs(destination: AboutUsViewController) {
        let navigation = TransitionNavigationViewController()
            .with(controller: destination)
        navigation.modalPresentationStyle = .fullScreen
        self.controller.present(navigation, animated: true, completion: nil)
    }
    
    func routeToContact() {
        let destinationVC: ContactViewController = self.injector.resolve()
        var destinationDS: ContactDataStore = destinationVC.router.dataStore
        self.passDataToContact(source: self.dataStore, destination: &destinationDS)
        self.navigateToContact(destination: destinationVC)
    }
    
    private func passDataToContact(source: InfoDataStore,
                                   destination: inout ContactDataStore) { }
    
    private func navigateToContact(destination: ContactViewController) {
        let navigation = TransitionNavigationViewController()
            .with(controller: destination)
        navigation.modalPresentationStyle = .fullScreen
        self.controller.present(navigation, animated: true, completion: nil)
    }
}
