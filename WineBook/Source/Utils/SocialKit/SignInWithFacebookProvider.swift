//
//  SignInWithFacebookProvider.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FBSDKLoginKit
import FormsSocialKit

// MARK: SignInWithFacebookProvider
class SignInWithFacebookProvider: SignInWithFacebookProviderBase {
    private lazy var loginManager: LoginManager = LoginManager()
    
    override func authorization(permissions: [String]) {
        self.loginManager.logIn(permissions: permissions, from: self.context) { [weak self] (result, error) in
            guard let `self` = self else { return }
            self.handleAuthorization(result: result, error: error)
        }
    }
    
    override func logout() {
        self.loginManager.logOut()
    }
    
    private func handleAuthorization(result: LoginManagerLoginResult?,
                                     error: Error?) {
        if let error: NSError = error as NSError? {
            self.onError?(error)
            self.onCompletion?(nil, error)
            self.clear()
        } else if let result: LoginManagerLoginResult = result {
            if result.isCancelled {
                self.onCancel?()
                self.onCompletion?(nil, nil)
                self.clear()
            } else {
                self.fetchUserInformation()
            }
        } else {
            let error: SignInWithFacebookError = .unableToLogIn
            self.onError?(error)
            self.onCompletion?(nil, error)
            self.clear()
        }
    }
    
    private func fetchUserInformation() {
        guard let accessToken: String = AccessToken.current?.tokenString else {
            let error: SignInWithFacebookError = .unableToRetrieveToken
            self.onError?(error)
            self.onCompletion?(nil, error)
            return
        }
        
        GraphRequest(
            graphPath: "/me",
            parameters: ["fields": "id, name, email"]
        ).start { [weak self] (_, result, error) in
            guard let `self` = self else { return }
            defer { self.clear() }
            if let error: Error = error {
                self.onError?(error)
                self.onCompletion?(nil, error)
                return
            } else if let result: Any = result {
                let data = SignInWithFacebookData(
                    accessToken: accessToken,
                    data: result)
                self.onSuccess?(data)
                self.onCompletion?(data, nil)
            } else {
                let error: SignInWithFacebookError = .unableToRetrieveUserInformation
                self.onError?(error)
                self.onCompletion?(nil, error)
            }
        }
    }
}
