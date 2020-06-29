//
//  LoginWithEmailInteractor.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: LoginWithEmailBusinessLogic
protocol LoginWithEmailBusinessLogic {
    func getContent(_ request: LoginWithEmail.GetContent.Request)
    func confirm(_ request: LoginWithEmail.Confirm.Request)
}

// MARK: LoginWithEmailDataStore
protocol LoginWithEmailDataStore {
    var model: LoginWithEmailModel { get }
}

// MARK: LoginWithEmailInteractor
class LoginWithEmailInteractor: LoginWithEmailBusinessLogic, LoginWithEmailDataStore {
    var presenter: LoginWithEmailPresentationLogic!
    var worker: LoginWithEmailWorker!

    let model: LoginWithEmailModel = LoginWithEmailModel()
    
    func getContent(_ request: LoginWithEmail.GetContent.Request) {
        let response = LoginWithEmail.GetContent.Response()
        self.presenter.presentContent(response)
    }
    
    func confirm(_ request: LoginWithEmail.Confirm.Request) {
        self.model.email = request.email
        self.worker.signInWithEmail(
            model: self.model,
            onSuccess: { [weak self] in
                guard let `self` = self else { return }
                let response = LoginWithEmail.Confirm.Response()
                self.presenter.presentConfirm(response)
        }, onError: { [weak self] (error) in
            guard let `self` = self else { return }
            let error = LoginWithEmail.Error(reason: error.debugDescription)
            self.presenter.presentConfirm(error)
        })
    }
}
