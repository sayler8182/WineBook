//
//  DashboardAssembly.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsInjector
import Foundation

// MARK: DashboardAssembly
class DashboardAssembly: Assembly {
    func assemble(injector: Injector) {
        injector.register(DashboardViewController.self) { _ in
            let interactor = DashboardInteractor()
            let presenter = DashboardPresenter()
            let router = DashboardRouter()
            let controller = DashboardViewController()
            let worker = DashboardWorker()
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
