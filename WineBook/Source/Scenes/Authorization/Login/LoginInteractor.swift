//
//  LoginInteractor.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: LoginBusinessLogic
protocol LoginBusinessLogic {
    func getContent(_ request: Login.GetContent.Request)
    func signInWithApple(_ request: Login.SignIn.WithApple.Request)
    func signInWithFacebook(_ request: Login.SignIn.WithFacebook.Request)
    func signInWithGoogle(_ request: Login.SignIn.WithGoogle.Request)
    func signInWithEmail(_ request: Login.SignIn.WithEmail.Request)
}

// MARK: LoginDataStore
protocol LoginDataStore {
}

// MARK: LoginInteractor
class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    var presenter: LoginPresentationLogic!
    var worker: LoginWorker!

    func getContent(_ request: Login.GetContent.Request) {
        let response = Login.GetContent.Response()
        self.presenter.presentContent(response)
    }
    
    func signInWithApple(_ request: Login.SignIn.WithApple.Request) {
        self.worker.signInWithApple(
            token: request.token,
            onSuccess: { [weak self] (response: LoginResponse) in
                guard let `self` = self else { return }
            let response = Login.SignIn.WithApple.Response()
            self.presenter.presentSignInWithApple(response)
        }, onError: { [weak self] (error) in
            guard let `self` = self else { return }
            let error = Login.Error(reason: error.debugDescription)
            self.presenter.presentSignInWithApple(error)
        })
    }
    
    func signInWithEmail(_ request: Login.SignIn.WithEmail.Request) {
        let response = Login.SignIn.WithEmail.Response()
        self.presenter.presentSignInWithEmail(response)
    }
    
    func signInWithFacebook(_ request: Login.SignIn.WithFacebook.Request) {
        self.worker.signInWithFacebook(
            token: request.token,
            onSuccess: { [weak self] (response: LoginResponse) in
                guard let `self` = self else { return }
                let response = Login.SignIn.WithFacebook.Response()
                self.presenter.presentSignInWithFacebook(response)
            }, onError: { [weak self] (error) in
                guard let `self` = self else { return }
                let error = Login.Error(reason: error.debugDescription)
                self.presenter.presentSignInWithFacebook(error)
        })
    }
    
    func signInWithGoogle(_ request: Login.SignIn.WithGoogle.Request) {
        self.worker.signInWithGoogle(
            token: request.token,
            onSuccess: { [weak self] (response: LoginResponse) in
                guard let `self` = self else { return }
                let response = Login.SignIn.WithGoogle.Response()
                self.presenter.presentSignInWithGoogle(response)
            }, onError: { [weak self] (error) in
                guard let `self` = self else { return }
                let error = Login.Error(reason: error.debugDescription)
                self.presenter.presentSignInWithGoogle(error)
        })
    }
}
