//
//  LoginWithEmailCodeInteractor.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: LoginWithEmailCodeBusinessLogic
protocol LoginWithEmailCodeBusinessLogic {
    func getContent(_ request: LoginWithEmailCode.GetContent.Request)
    func confirm(_ request: LoginWithEmailCode.Confirm.Request)
}

// MARK: LoginWithEmailCodeDataStore
protocol LoginWithEmailCodeDataStore {
    var model: LoginWithEmailCodeModel { get }
}

// MARK: LoginWithEmailCodeInteractor
class LoginWithEmailCodeInteractor: LoginWithEmailCodeBusinessLogic, LoginWithEmailCodeDataStore {
    var presenter: LoginWithEmailCodePresentationLogic!
    var worker: LoginWithEmailCodeWorker!

    let model: LoginWithEmailCodeModel = LoginWithEmailCodeModel()
    
    func getContent(_ request: LoginWithEmailCode.GetContent.Request) {
        let response = LoginWithEmailCode.GetContent.Response()
        self.presenter.presentContent(response)
    }
    
    func confirm(_ request: LoginWithEmailCode.Confirm.Request) {
        self.model.code = request.code
        self.worker.signInWithEmailCode(
            model: self.model,
            onSuccess: { [weak self] (response: LoginWithEmailCodeResponse) in
                guard let `self` = self else { return }
                let isUserExist: Bool = response.mode == .USER_EXIST
                let response = LoginWithEmailCode.Confirm.Response(
                    isUserExist: isUserExist)
                self.presenter.presentConfirm(response)
        }, onError: { [weak self] (error) in
            guard let `self` = self else { return }
            let error = LoginWithEmailCode.Error(reason: error.debugDescription)
            self.presenter.presentConfirm(error)
        })
    }
}
