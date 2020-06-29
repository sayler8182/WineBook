//
//  DiscountAssembly.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsInjector
import Foundation

// MARK: DiscountAssembly
class DiscountAssembly: Assembly {
    func assemble(injector: Injector) {
        injector.register(DiscountViewController.self) { _ in
            let interactor = DiscountInteractor()
            let presenter = DiscountPresenter()
            let router = DiscountRouter()
            let controller = DiscountViewController()
            let worker = DiscountWorker()
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
