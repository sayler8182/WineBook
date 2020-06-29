//
//  RegisterWithEmailWorker.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: RegisterWithEmailWorker
class RegisterWithEmailWorker {
    func signUpWithEmail(model: RegisterWithEmailModel,
                         onSuccess: @escaping (LoginResponse) -> Void,
                         onError: @escaping (NetworkError) -> Void) {
        let content = NetworkMethods.auth.signUpWithEmail.Content(
            email: model.email ?? "",
            name: model.name ?? "",
            code: model.code ?? "",
            birthDate: model.birthDate ?? "",
            password: model.password ?? "")
        NetworkMethods.auth.signUpWithEmail(content)
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
