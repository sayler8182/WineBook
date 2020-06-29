//
//  RegisterWithEmailInteractor.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: RegisterWithEmailBusinessLogic
protocol RegisterWithEmailBusinessLogic {
    func getContent(_ request: RegisterWithEmail.GetContent.Request)
    func signUp(_ request: RegisterWithEmail.SignUp.Request)
}

// MARK: RegisterWithEmailDataStore
protocol RegisterWithEmailDataStore {
    var model: RegisterWithEmailModel { get }
}

// MARK: RegisterWithEmailInteractor
class RegisterWithEmailInteractor: RegisterWithEmailBusinessLogic, RegisterWithEmailDataStore {
    var presenter: RegisterWithEmailPresentationLogic!
    var worker: RegisterWithEmailWorker!

    let model: RegisterWithEmailModel = RegisterWithEmailModel()
    
    func getContent(_ request: RegisterWithEmail.GetContent.Request) {
        let response = RegisterWithEmail.GetContent.Response()
        self.presenter.presentContent(response)
    }
    
    func signUp(_ request: RegisterWithEmail.SignUp.Request) {
        self.model.name = request.name
        self.model.birthDate = request.birthDate
        self.model.password = request.password
        self.worker.signUpWithEmail(
            model: self.model,
            onSuccess: { [weak self] (response: LoginResponse) in
                guard let `self` = self else { return }
                let response = RegisterWithEmail.SignUp.Response()
                self.presenter.presentSignUp(response)
            }, onError: { [weak self] (error) in
                guard let `self` = self else { return }
                let error = RegisterWithEmail.Error(reason: error.debugDescription)
                self.presenter.presentSignUp(error)
        })
    }
}
