//
//  PurchasesAssembly.swift
//  WineBook
//
//  Created by Konrad on 6/26/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsInjector
import Foundation

// MARK: PurchasesAssembly
class PurchasesAssembly: Assembly {
    func assemble(injector: Injector) {
        injector.register(PurchasesViewController.self) { _ in
            let interactor = PurchasesInteractor()
            let presenter = PurchasesPresenter()
            let router = PurchasesRouter()
            let controller = PurchasesViewController()
            let worker = PurchasesWorker()
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
