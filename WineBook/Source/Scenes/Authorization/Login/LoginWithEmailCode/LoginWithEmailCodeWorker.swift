//
//  LoginWithEmailCodeWorker.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: LoginWithEmailCodeWorker
class LoginWithEmailCodeWorker {
    func signInWithEmailCode(model: LoginWithEmailCodeModel,
                             onSuccess: @escaping (LoginWithEmailCodeResponse) -> Void,
                             onError: @escaping (NetworkError) -> Void) {
        let content = NetworkMethods.auth.signInWithEmailCode.Content(
            email: model.email ?? "",
            code: model.code ?? "")
        NetworkMethods.auth.signInWithEmailCode(content)
            .call(onSuccess: { (data: LoginWithEmailCodeResponse) in
                onSuccess(data)
            }, onError: { (error) in
                onError(error)
            }, onCompletion: nil)
    }
}
