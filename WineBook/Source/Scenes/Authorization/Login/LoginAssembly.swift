//
//  LoginAssembly.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsInjector
import Foundation

// MARK: LoginAssembly
class LoginAssembly: Assembly {
    func assemble(injector: Injector) {
        injector.register(LoginViewController.self) { _ in
            let interactor = LoginInteractor()
            let presenter = LoginPresenter()
            let router = LoginRouter()
            let controller = LoginViewController()
            let worker = LoginWorker()
            interactor.presenter = presenter
            interactor.worker = worker
            presenter.controller = controller
            controller.interactor = interactor
            controller.router = router
            router.controller = controller
            router.dataStore = interactor
            if #available(iOS 13.0, *) {
                controller.signInWithAppleProvider = SignInWithAppleProvider(context: controller)
            } 
            controller.signInWithFacebookProvider = SignInWithFacebookProvider(context: controller)
            controller.signInWithGoogleProvider = SignInWithGoogleProvider(context: controller)
            return controller
        }
    } 
}
