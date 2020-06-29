//
//  ProfileAssembly.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsInjector
import Foundation

// MARK: ProfileAssembly
class ProfileAssembly: Assembly {
    func assemble(injector: Injector) {
        injector.register(ProfileViewController.self) { _ in
            let interactor = ProfileInteractor()
            let presenter = ProfilePresenter()
            let router = ProfileRouter()
            let controller = ProfileViewController()
            let worker = ProfileWorker()
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
