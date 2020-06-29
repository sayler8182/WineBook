//
//  SplashAssembly.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsInjector
import Foundation

// MARK: SplashAssembly
class SplashAssembly: Assembly {
    func assemble(injector: Injector) {
        injector.register(SplashViewController.self) { _ in
            let interactor = SplashInteractor()
            let presenter = SplashPresenter()
            let router = SplashRouter()
            let controller = SplashViewController()
            let worker = SplashWorker()
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
