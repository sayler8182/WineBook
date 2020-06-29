//
//  ContactRouter.swift
//  WineBook
//
//  Created by Konrad on 6/25/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsInjector
import UIKit

// MARK: ContactRoutingLogic
protocol ContactRoutingLogic {
    func routeToPhone()
    func routeToEmail()
    func routeToAddress()
}

// MARK: ContactDataPassing
protocol ContactDataPassing {
    var dataStore: ContactDataStore! { get }
}

// MARK: ContactRouter
class ContactRouter: ContactRoutingLogic, ContactDataPassing {
    weak var controller: ContactViewController!
    var dataStore: ContactDataStore!
    private let injector: Injector = Forms.injector
    
    func routeToPhone() {
        let phone: String = self.dataStore.phone
        guard let url: URL = "tel://\(phone)".url else { return }
        UIApplication.shared.open(url)
    }
    
    func routeToEmail() {
        let email: String = self.dataStore.email
        guard let url: URL = "mailto:\(email)".url else { return }
        UIApplication.shared.open(url)
    }
    
    func routeToAddress() {
        let address: String = self.dataStore.address
        guard let url: URL = "https://maps.apple.com/?q=\(address)".url else { return }
        UIApplication.shared.open(url)
    }
}
