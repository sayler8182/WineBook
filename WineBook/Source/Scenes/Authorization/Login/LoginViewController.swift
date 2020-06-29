//
//  LoginViewController.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import AuthenticationServices
import Forms
import FormsAnchor
import FormsSocialKit
import FormsToastKit
import UIKit

// MARK: LoginDisplayLogic
protocol LoginDisplayLogic: class {
    func displayContent(_ viewModel: Login.GetContent.ViewModel)
    func displaySignInWithApple(_ viewModel: Login.SignIn.WithApple.ViewModel)
    func displaySignInWithApple(_ error: Login.Error)
    func displaySignInWithEmail(_ viewModel: Login.SignIn.WithEmail.ViewModel)
    func displaySignInWithFacebook(_ viewModel: Login.SignIn.WithFacebook.ViewModel)
    func displaySignInWithFacebook(_ error: Login.Error)
    func displaySignInWithGoogle(_ viewModel: Login.SignIn.WithGoogle.ViewModel)
    func displaySignInWithGoogle(_ error: Login.Error)
}

// MARK: LoginViewController
class LoginViewController: FormsViewController, LoginDisplayLogic {
    var interactor: LoginBusinessLogic!
    var router: (LoginRoutingLogic & LoginDataPassing)!
    
    @available(iOS 13.0, *)
    lazy var signInWithAppleProvider: SignInWithAppleProvider! = nil
    var signInWithFacebookProvider: SignInWithFacebookProvider!
    var signInWithGoogleProvider: SignInWithGoogleProvider!
    
    private var logo = Components.logo.big()
    private var signInContent = Components.container.stack()
        .with(axis: .vertical)
        .with(distribution: .equalSpacing)
        .with(spacing: 8.0)
    @available(iOS 13.0, *)
    private lazy var signInWithAppleButton = Components.social.signInWithApple()
        .with(anchors: { [Anchor.to($0).height(36.0)] })
        .with(title: "Sign in with Apple")
    private var signInWithFacebookButton = Components.social.signInWithFacebook()
        .with(anchors: { [Anchor.to($0).height(36.0)] })
        .with(title: "Sign in with Facebook")
    private var signInWithGoogleButton = Components.social.signInWithGoogle()
        .with(anchors: { [Anchor.to($0).height(36.0)] })
        .with(title: "Sign in with Google")
    private var signInWithEmailButton = Components.social.signInWithEmail()
        .with(anchors: { [Anchor.to($0).height(36.0)] })
        .with(gradientColors: [
            Theme.Colors.secondary,
            Theme.Colors.primary
        ])
        .with(title: "Sign in with Email")
    
    override func setupView() {
        super.setupView()
        self.getContent()
    }
    
    override func setTheme() {
        super.setTheme()
        self.view.backgroundColor = Theme.Colors.primaryLight
        self.logo.backgroundColor = Theme.Colors.primaryLight
    }
    
    override func setupContent() {
        super.setupContent()
        self.setupSignInContent()
        self.view.addSubview(self.logo, with: [
            Anchor.to(self.view).horizontal.offset(16),
            Anchor.to(self.view).centerY.priority(.defaultLow)
        ])
        self.view.addSubview(self.signInContent, with: [
            Anchor.to(self.logo).topToBottom.greaterThanOrEqual.offset(16),
            Anchor.to(self.view).horizontal.offset(16),
            Anchor.to(self.view).bottom.safeArea.offset(16)
        ])
    }
    
    private func setupSignInContent() {
        if #available(iOS 13.0, *) {
            self.signInContent.setItems([
                self.signInWithAppleButton,
                self.signInWithFacebookButton,
                self.signInWithGoogleButton,
                self.signInWithEmailButton
            ])
        } else {
            self.signInContent.setItems([
                self.signInWithFacebookButton,
                self.signInWithGoogleButton,
                self.signInWithEmailButton
            ])
        }
    }
    
    override func setupActions() {
        super.setupActions()
        if #available(iOS 13.0, *) {
            self.signInWithAppleButton.onClick = { [unowned self] in
                self.signInWithApple()
            }
        }
        self.signInWithFacebookButton.onClick = { [unowned self] in
            self.signInWithFacebook()
        }
        self.signInWithGoogleButton.onClick = { [unowned self] in
            self.signInWithGoogle()
        }
        self.signInWithEmailButton.onClick = { [unowned self] in
            self.signInWithEmail()
        }
    }
}

// MARK: LoginDisplayLogic - GetContent
extension LoginViewController {
    private func getContent() {
        let request = Login.GetContent.Request()
        self.interactor.getContent(request)
    }
    
    func displayContent(_ viewModel: Login.GetContent.ViewModel) { }
}

// MARK: LoginDisplayLogic - SignIn - WithApple
extension LoginViewController {
    @available(iOS 13.0, *)
    private func signInWithApple() {
        self.signInWithAppleButton.startLoading()
        self.signInWithAppleProvider.authorization(
            scopes: [ASAuthorization.Scope.email],
            onSuccess: { [weak self] (data) in
                guard let `self` = self else { return }
                self.signInWithAppleConfirm(token: data.jwt)
            },
            onError: { [weak self] (error) in
                guard let `self` = self else { return }
                Toast.error()
                    .with(title: "Sign in with Apple Error")
                    .show(in: self)
                self.signInWithAppleButton.stopLoading()
            },
            onCancel: { [weak self] in
                guard let `self` = self else { return }
                self.signInWithAppleButton.stopLoading()
        })
    }
    
    private func signInWithAppleConfirm(token: String) {
        let request = Login.SignIn.WithApple.Request(
            token: token)
        self.interactor.signInWithApple(request)
    }
    
    func displaySignInWithApple(_ viewModel: Login.SignIn.WithApple.ViewModel) {
        if #available(iOS 13.0, *) {
            self.signInWithAppleButton.stopLoading()
            self.router.routeToDashboard()
        }
    }
    
    func displaySignInWithApple(_ error: Login.Error) {
        if #available(iOS 13.0, *) {
            self.signInWithAppleButton.stopLoading()
            Toast.error()
                .with(title: error.reason)
                .show(in: self)
        }
    }
}

// MARK: LoginDisplayLogic - SignIn - WithEmail
extension LoginViewController {
    private func signInWithEmail() {
        self.signInWithEmailButton.startLoading()
        let request = Login.SignIn.WithEmail.Request()
        self.interactor.signInWithEmail(request)
    }
    
    func displaySignInWithEmail(_ viewModel: Login.SignIn.WithEmail.ViewModel) {
        self.signInWithEmailButton.stopLoading()
        self.router.routeToLoginWithEmail()
    }
}

// MARK: LoginDisplayLogic - SignIn - WithFacebook
extension LoginViewController {
    private func signInWithFacebook() {
        self.signInWithFacebookButton.startLoading()
        self.signInWithFacebookProvider.authorization(
            permissions: ["email", "public_profile"],
            onSuccess: { [weak self] (data) in
                guard let `self` = self else { return }
                self.signInWithFacebookConfirm(token: data.accessToken)
            },
            onError: { [weak self] (error) in
                guard let `self` = self else { return }
                Toast.error()
                    .with(title: "Sign in with Facebook Error")
                    .show(in: self)
                self.signInWithFacebookButton.stopLoading()
            },
            onCancel: { [weak self] in
                guard let `self` = self else { return }
                self.signInWithFacebookButton.stopLoading()
        })
    }
    
    private func signInWithFacebookConfirm(token: String) {
        let request = Login.SignIn.WithFacebook.Request(
            token: token)
        self.interactor.signInWithFacebook(request)
    }
    
    func displaySignInWithFacebook(_ viewModel: Login.SignIn.WithFacebook.ViewModel) {
        self.signInWithFacebookButton.stopLoading()
        self.router.routeToDashboard()
    }
    
    func displaySignInWithFacebook(_ error: Login.Error) {
        self.signInWithFacebookButton.stopLoading()
        Toast.error()
            .with(title: error.reason)
            .show(in: self)
    }
}

// MARK: LoginDisplayLogic - SignIn - WithGoogle
extension LoginViewController {
    private func signInWithGoogle() {
        self.signInWithGoogleButton.startLoading()
        self.signInWithGoogleProvider.authorization(
            onSuccess: { [weak self] (data) in
                guard let `self` = self else { return }
                self.signInWithGoogleConfirm(token: data.authenticationToken)
            },
            onError: { [weak self] (error) in
                guard let `self` = self else { return }
                Toast.error()
                    .with(title: "Sign in with Facebook Error")
                    .show(in: self)
                self.signInWithGoogleButton.stopLoading()
            },
            onCancel: { [weak self] in
                guard let `self` = self else { return }
                self.signInWithGoogleButton.stopLoading()
        })
    }
    
    private func signInWithGoogleConfirm(token: String) {
        let request = Login.SignIn.WithGoogle.Request(
            token: token)
        self.interactor.signInWithGoogle(request)
    }
    
    func displaySignInWithGoogle(_ viewModel: Login.SignIn.WithGoogle.ViewModel) {
        self.signInWithGoogleButton.stopLoading()
        self.router.routeToDashboard()
    }
    
    func displaySignInWithGoogle(_ error: Login.Error) {
        self.signInWithGoogleButton.stopLoading()
        Toast.error()
            .with(title: error.reason)
            .show(in: self)
    }
}
