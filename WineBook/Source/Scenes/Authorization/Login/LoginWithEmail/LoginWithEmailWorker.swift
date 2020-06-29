//
//  LoginWithEmailWorker.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: LoginWithEmailWorker
class LoginWithEmailWorker {
    func signInWithEmail(model: LoginWithEmailModel,
                         onSuccess: @escaping () -> Void,
                         onError: @escaping (NetworkError) -> Void) {
        let content = NetworkMethods.auth.signInWithEmail.Content(
            email: model.email ?? "")
        NetworkMethods.auth.signInWithEmail(content)
            .call(onSuccess: { (_) in
                onSuccess()
            }, onError: { (error) in
                onError(error)
            }, onCompletion: nil)
    }
}
