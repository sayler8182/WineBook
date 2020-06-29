//
//  InfoAssembly.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsInjector
import Foundation

// MARK: InfoAssembly
class InfoAssembly: Assembly {
    func assemble(injector: Injector) {
        injector.register(InfoViewController.self) { _ in
            let interactor = InfoInteractor()
            let presenter = InfoPresenter()
            let router = InfoRouter()
            let controller = InfoViewController()
            let worker = InfoWorker()
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
