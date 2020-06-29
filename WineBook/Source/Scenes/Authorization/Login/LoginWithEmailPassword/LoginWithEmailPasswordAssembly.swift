//
//  LoginWithEmailPasswordAssembly.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsInjector
import Foundation

// MARK: LoginWithEmailPasswordAssembly
class LoginWithEmailPasswordAssembly: Assembly {
    func assemble(injector: Injector) {
        injector.register(LoginWithEmailPasswordViewController.self) { _ in
            let interactor = LoginWithEmailPasswordInteractor()
            let presenter = LoginWithEmailPasswordPresenter()
            let router = LoginWithEmailPasswordRouter()
            let controller = LoginWithEmailPasswordViewController()
            let worker = LoginWithEmailPasswordWorker()
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
