//
//  ContactAssembly.swift
//  WineBook
//
//  Created by Konrad on 6/25/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsInjector
import Foundation

// MARK: ContactAssembly
class ContactAssembly: Assembly {
    func assemble(injector: Injector) {
        injector.register(ContactViewController.self) { _ in
            let interactor = ContactInteractor()
            let presenter = ContactPresenter()
            let router = ContactRouter()
            let controller = ContactViewController()
            let worker = ContactWorker()
            interactor.presenter = presenter
            interactor.worker = worker
            presenter.controller = controller
            controller.interactor = interactor
            controller.router = router
            router.controller = controller
            router.dataStore = interactor
            return controller
        }
    } 
}
