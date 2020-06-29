//
//  LoginWorker.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: LoginWorker
class LoginWorker {
    func signInWithApple(token: String,
                         onSuccess: @escaping (LoginResponse) -> Void,
                         onError: @escaping (NetworkError) -> Void) {
        let content = NetworkMethods.auth.signInWithApple.Content(
            token: token)
        NetworkMethods.auth.signInWithApple(content)
            .call(onSuccess: { (data: LoginResponse) in
                self.signInSuccess(data)
                onSuccess(data)
            }, onError: { (error) in
                onError(error)
            }, onCompletion: nil)
    }
    
    func signInWithFacebook(token: String,
                            onSuccess: @escaping (LoginResponse) -> Void,
                            onError: @escaping (NetworkError) -> Void) {
        let content = NetworkMethods.auth.signInWithFacebook.Content(
            token: token)
        NetworkMethods.auth.signInWithFacebook(content)
            .call(onSuccess: { (data: LoginResponse) in
                self.signInSuccess(data)
                onSuccess(data)
            }, onError: { (error) in
                onError(error)
            }, onCompletion: nil)
    }
    
    func signInWithGoogle(token: String,
                          onSuccess: @escaping (LoginResponse) -> Void,
                          onError: @escaping (NetworkError) -> Void) {
        let content = NetworkMethods.auth.signInWithGoogle.Content(
            token: token)
        NetworkMethods.auth.signInWithGoogle(content)
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
