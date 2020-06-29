//
//  ProductDetailsAssembly.swift
//  WineBook
//
//  Created by Konrad on 6/23/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsInjector
import Foundation

// MARK: ProductDetailsAssembly
class ProductDetailsAssembly: Assembly {
    func assemble(injector: Injector) {
        injector.register(ProductDetailsViewController.self) { _ in
            let interactor = ProductDetailsInteractor()
            let presenter = ProductDetailsPresenter()
            let router = ProductDetailsRouter()
            let controller = ProductDetailsViewController()
            let worker = ProductDetailsWorker()
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
