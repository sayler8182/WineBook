//
//  LoginWithEmailPasswordWorker.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: LoginWithEmailPasswordWorker
class LoginWithEmailPasswordWorker {
    func signInWithEmailPassword(model: LoginWithEmailPasswordModel,
                                 onSuccess: @escaping (LoginResponse) -> Void,
                                 onError: @escaping (NetworkError) -> Void) {
        let content = NetworkMethods.auth.signInWithEmailPassword.Content(
            email: model.email ?? "",
            code: model.code ?? "",
            password: model.password ?? "")
        NetworkMethods.auth.signInWithEmailPassword(content)
            .call(onSuccess: { (data: LoginResponse) in
                self.signInSuccess(data)
                onSuccess(data)
            }, onError: { (error) in
                onError(error)
            }, onCompletion: nil)
    }
    
    fileprivate func signInSuccess(_ data: LoginResponse) {
        Storage.token.value = data.token
    }
}
