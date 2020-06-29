//
//  LoginWithEmailPasswordInteractor.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: LoginWithEmailPasswordBusinessLogic
protocol LoginWithEmailPasswordBusinessLogic {
    func getContent(_ request: LoginWithEmailPassword.GetContent.Request)
    func confirm(_ request: LoginWithEmailPassword.Confirm.Request)
}

// MARK: LoginWithEmailPasswordDataStore
protocol LoginWithEmailPasswordDataStore {
    var model: LoginWithEmailPasswordModel { get }
}

// MARK: LoginWithEmailPasswordInteractor
class LoginWithEmailPasswordInteractor: LoginWithEmailPasswordBusinessLogic, LoginWithEmailPasswordDataStore {
    var presenter: LoginWithEmailPasswordPresentationLogic!
    var worker: LoginWithEmailPasswordWorker!

    let model: LoginWithEmailPasswordModel = LoginWithEmailPasswordModel()
    
    func getContent(_ request: LoginWithEmailPassword.GetContent.Request) {
        let response = LoginWithEmailPassword.GetContent.Response()
        self.presenter.presentContent(response)
    }
    
    func confirm(_ request: LoginWithEmailPassword.Confirm.Request) {
        self.model.password = request.password
        self.worker.signInWithEmailPassword(
            model: self.model,
            onSuccess: { [weak self] (response: LoginResponse) in
                guard let `self` = self else { return }
                let response = LoginWithEmailPassword.Confirm.Response()
                self.presenter.presentConfirm(response)
        }, onError: { [weak self] (error) in
            guard let `self` = self else { return }
            let error = LoginWithEmailPassword.Error(reason: error.debugDescription)
            self.presenter.presentConfirm(error)
        })
    }
}
