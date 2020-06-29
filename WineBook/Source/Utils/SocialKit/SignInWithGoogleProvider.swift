//
//  SignInWithGoogleProvider.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsSocialKit
import GoogleSignIn

// MARK: SignInWithGoogleProvider
class SignInWithGoogleProvider: SignInWithGoogleProviderBase, GIDSignInDelegate {
    override func authorization() {
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self.context
        GIDSignIn.sharedInstance().signIn()
    }
    
    override func logout() {
        GIDSignIn.sharedInstance()?.signOut()
    }
    
    func sign(_ signIn: GIDSignIn!,
              didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        defer { self.clear() }
        self.onError?(error)
        self.onCompletion?(nil, error)
    }
    
    func sign(_ signIn: GIDSignIn!,
              didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        defer { self.clear() }
        if let error: NSError = error as NSError? {
            if error.code == GIDSignInErrorCode.canceled.rawValue {
                self.onCancel?()
                self.onCompletion?(nil, nil)
            } else {
                self.onError?(error)
                self.onCompletion?(nil, error)
            }
        } else if let user: GIDGoogleUser = user {
            let data = SignInWithGoogleData(
                userId: user.userID,
                authenticationToken: user.authentication.idToken,
                email: user.profile.email,
                fullName: user.profile.name,
                givenName: user.profile.givenName,
                familyName: user.profile.familyName)
            self.onSuccess?(data)
            self.onCompletion?(data, nil)
        } else {
            let error: SignInWithGoogleError = .unableToLogIn
            self.onError?(error)
            self.onCompletion?(nil, error)
        }
    }
}
