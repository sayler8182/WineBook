//
//  LoginWithEmailPasswordViewController.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsToastKit
import FormsValidators
import UIKit

// MARK: LoginWithEmailPasswordDisplayLogic
protocol LoginWithEmailPasswordDisplayLogic: class {
    func displayContent(_ viewModel: LoginWithEmailPassword.GetContent.ViewModel)
    func displayConfirm(_ viewModel: LoginWithEmailPassword.Confirm.ViewModel)
    func displayConfirm(_ error: LoginWithEmailPassword.Error)
}

// MARK: LoginWithEmailPasswordViewController
class LoginWithEmailPasswordViewController: FormsTableViewController, LoginWithEmailPasswordDisplayLogic {
    var interactor: LoginWithEmailPasswordBusinessLogic!
    var router: (LoginWithEmailPasswordRoutingLogic & LoginWithEmailPasswordDataPassing)!

    private let navigationBar = Components.navigationBar.main()
    private let titleLabel = Components.label.title.auth()
        .with(text: "Password")
    private let subtitleLabel = Components.label.subtitle()
        .with(text: " ")
    private let passwordInput = Components.input.textField.password.main()
        .with(title: "Enter password")
        .with(validator: PasswordValidator())
    private let confirmButton = Components.button.primary()
        .with(title: "Confirm")
    
    override func setupView() {
        super.setupView()
        self.getContent()
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()
        self.setNavigationBar(self.navigationBar)
    }
    
    override func setupContent() {
        super.setupContent()
        self.build([
            self.titleLabel,
            self.subtitleLabel,
            self.passwordInput,
            self.confirmButton
        ])
    }
    
    override func setupActions() {
        super.setupActions()
        self.confirmButton.onClick = { [unowned self] in
            guard self.validateWithTrigger() else { return }
            self.dismissKeyboard()
            self.confirm()
        }
        self.passwordInput.onTextChanged = { [unowned self] _ in
            guard self.passwordInput.validateOnTextChange else { return }
            self.validate()
        }
        self.onValidate = { [unowned self] (result) in
            self.passwordInput.validateOnTextChange = true
            self.confirmButton.isEnabled = result
        }
    }
}

// MARK: LoginWithEmailPasswordDisplayLogic - GetContent
extension LoginWithEmailPasswordViewController {
    private func getContent() {
        let request = LoginWithEmailPassword.GetContent.Request()
        self.interactor.getContent(request)
    }

    func displayContent(_ viewModel: LoginWithEmailPassword.GetContent.ViewModel) {
    }
}

// MARK: LoginWithEmailPasswordDisplayLogic - Confirm
extension LoginWithEmailPasswordViewController {
    private func confirm() {
        self.confirmButton.startLoading()
        let request = LoginWithEmailPassword.Confirm.Request(
            password: self.passwordInput.text)
        self.interactor.confirm(request)
    }

    func displayConfirm(_ viewModel: LoginWithEmailPassword.Confirm.ViewModel) {
        self.confirmButton.stopLoading()
        self.router.routeToDashboard()
    }
    
    func displayConfirm(_ error: LoginWithEmailPassword.Error) {
        self.confirmButton.stopLoading()
        Toast.error()
            .with(title: error.reason)
            .show(in: self.navigationController)
    }
}

#if DEBUG
import FormsMock
extension LoginWithEmailPasswordViewController {
    override func setupMock() {
        let mock = Mock()
        self.passwordInput.text = mock.password()
    }
}
#endif
