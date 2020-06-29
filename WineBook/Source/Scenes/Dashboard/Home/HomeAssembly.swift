//
//  HomeAssembly.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsInjector
import Foundation

// MARK: HomeAssembly
class HomeAssembly: Assembly {
    func assemble(injector: Injector) {
        injector.register(HomeViewController.self) { _ in
            let interactor = HomeInteractor()
            let presenter = HomePresenter()
            let router = HomeRouter()
            let controller = HomeViewController()
            let worker = HomeWorker()
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
