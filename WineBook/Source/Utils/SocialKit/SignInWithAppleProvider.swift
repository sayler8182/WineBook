//
//  SignInWithAppleProvider.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import AuthenticationServices
import FormsSocialKit

// MARK: SignInWithAppleProvider
@available(iOS 13.0, *)
class SignInWithAppleProvider: SignInWithAppleProviderBase, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    override func authorization(scopes: [Any]) {
        let authorizationProvider = ASAuthorizationAppleIDProvider()
        let request: ASAuthorizationAppleIDRequest = authorizationProvider.createRequest()
        request.requestedScopes = scopes as? [ASAuthorization.Scope]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    override func logout() {
        let authorizationProvider = ASAuthorizationAppleIDProvider()
        let request: ASAuthorizationAppleIDRequest = authorizationProvider.createRequest()
        request.requestedOperation = .operationLogout
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.context.view.window ?? ASPresentationAnchor()
    }
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        defer { self.clear() }
        switch authorization.credential {
        case let credential as ASAuthorizationAppleIDCredential:
            self.handleASAuthorizationAppleIDCredential(credential)
        default:
            let error: SignInWithAppleError = .unableToHandleCredential
            self.onError?(error)
            self.onCompletion?(nil, error)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithError error: Error) {
        defer { self.clear() }
        let error = error as NSError
        if error.code == ASAuthorizationError.canceled.rawValue {
            self.onCancel?()
            self.onCompletion?(nil, nil)
        } else {
            self.onError?(error)
            self.onCompletion?(nil, error)
        }
    }
    
    private func handleASAuthorizationAppleIDCredential(_ credential: ASAuthorizationAppleIDCredential) {
        defer { self.clear() }
        guard let jwtData: Data = credential.identityToken,
            let jwt: String = String(data: jwtData, encoding: .utf8) else {
                let error: SignInWithAppleError = .unableToRetrieveJWT
                self.onError?(error)
                self.onCompletion?(nil, error)
                return
        }
        let data = SignInWithAppleData(
            uid: credential.user,
            jwt: jwt,
            email: credential.email,
            nickname: credential.fullName?.nickname)
        self.onSuccess?(data)
        self.onCompletion?(data, nil)
    }
}
