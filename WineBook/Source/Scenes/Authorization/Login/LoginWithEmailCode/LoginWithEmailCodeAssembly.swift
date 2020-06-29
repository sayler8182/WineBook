//
//  LoginWithEmailCodeAssembly.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsInjector
import Foundation

// MARK: LoginWithEmailCodeAssembly
class LoginWithEmailCodeAssembly: Assembly {
    func assemble(injector: Injector) {
        injector.register(LoginWithEmailCodeViewController.self) { _ in
            let interactor = LoginWithEmailCodeInteractor()
            let presenter = LoginWithEmailCodePresenter()
            let router = LoginWithEmailCodeRouter()
            let controller = LoginWithEmailCodeViewController()
            let worker = LoginWithEmailCodeWorker()
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
