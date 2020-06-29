//
//  AboutUsAssembly.swift
//  WineBook
//
//  Created by Konrad on 6/25/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsInjector
import Foundation

// MARK: AboutUsAssembly
class AboutUsAssembly: Assembly {
    func assemble(injector: Injector) {
        injector.register(AboutUsViewController.self) { _ in
            let interactor = AboutUsInteractor()
            let presenter = AboutUsPresenter()
            let router = AboutUsRouter()
            let controller = AboutUsViewController()
            let worker = AboutUsWorker()
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
