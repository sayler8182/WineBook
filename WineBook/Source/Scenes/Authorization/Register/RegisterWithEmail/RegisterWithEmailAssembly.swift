//
//  RegisterWithEmailAssembly.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsInjector
import Foundation

// MARK: RegisterWithEmailAssembly
class RegisterWithEmailAssembly: Assembly {
    func assemble(injector: Injector) {
        injector.register(RegisterWithEmailViewController.self) { _ in
            let interactor = RegisterWithEmailInteractor()
            let presenter = RegisterWithEmailPresenter()
            let router = RegisterWithEmailRouter()
            let controller = RegisterWithEmailViewController()
            let worker = RegisterWithEmailWorker()
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
