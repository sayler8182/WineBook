//
//  LoginWithEmailAssembly.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsInjector
import Foundation

// MARK: LoginWithEmailAssembly
class LoginWithEmailAssembly: Assembly {
    func assemble(injector: Injector) {
        injector.register(LoginWithEmailViewController.self) { _ in
            let interactor = LoginWithEmailInteractor()
            let presenter = LoginWithEmailPresenter()
            let router = LoginWithEmailRouter()
            let controller = LoginWithEmailViewController()
            let worker = LoginWithEmailWorker()
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
