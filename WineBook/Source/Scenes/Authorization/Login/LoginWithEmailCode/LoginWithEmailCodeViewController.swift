//
//  LoginWithEmailCodeViewController.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsToastKit
import FormsValidators
import UIKit

// MARK: LoginWithEmailCodeDisplayLogic
protocol LoginWithEmailCodeDisplayLogic: class {
    func displayContent(_ viewModel: LoginWithEmailCode.GetContent.ViewModel)
    func displayConfirm(_ viewModel: LoginWithEmailCode.Confirm.ViewModel)
    func displayConfirm(_ error: LoginWithEmailCode.Error)
}

// MARK: LoginWithEmailCodeViewController
class LoginWithEmailCodeViewController: FormsTableViewController, LoginWithEmailCodeDisplayLogic {
    var interactor: LoginWithEmailCodeBusinessLogic!
    var router: (LoginWithEmailCodeRoutingLogic & LoginWithEmailCodeDataPassing)!

    private let navigationBar = Components.navigationBar.main()
    private let titleLabel = Components.label.title.auth()
        .with(text: "Confirmation code")
    private let subtitleLabel = Components.label.subtitle()
        .with(text: "We sent confirmation code to your email")
    private let codeInput = Components.input.textField.password.main()
        .with(keyboardType: .numberPad)
        .with(title: "Enter confirmation code")
        .with(validators: [
            StringValidator(set: .numeric),
            LengthValidator(length: 6)
        ])
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
            self.codeInput,
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
        self.codeInput.onTextChanged = { [unowned self] _ in
            guard self.codeInput.validateOnTextChange else { return }
            self.validate()
        }
        self.onValidate = { [unowned self] (result) in
            self.codeInput.validateOnTextChange = true
            self.confirmButton.isEnabled = result
        }
    }
}

// MARK: LoginWithEmailCodeDisplayLogic - GetContent
extension LoginWithEmailCodeViewController {
    private func getContent() {
        let request = LoginWithEmailCode.GetContent.Request()
        self.interactor.getContent(request)
    }

    func displayContent(_ viewModel: LoginWithEmailCode.GetContent.ViewModel) { }
}

// MARK: LoginWithEmailCodeDisplayLogic - Confirm
extension LoginWithEmailCodeViewController {
    private func confirm() {
        self.confirmButton.startLoading()
        let request = LoginWithEmailCode.Confirm.Request(
            code: self.codeInput.text)
        self.interactor.confirm(request)
    }

    func displayConfirm(_ viewModel: LoginWithEmailCode.Confirm.ViewModel) {
        self.confirmButton.stopLoading()
        if viewModel.isUserExist {
            self.router.routeToLoginWithEmailPassword()
        } else {
            self.router.routeToRegisterWithEmail()
        }
    }
    
    func displayConfirm(_ error: LoginWithEmailCode.Error) {
        self.confirmButton.stopLoading()
        Toast.error()
            .with(title: error.reason)
            .show(in: self.navigationController)
    }
}

#if DEBUG
import FormsMock
extension LoginWithEmailCodeViewController {
    override func setupMock() {
        let mock = Mock()
        self.codeInput.text = mock.number((100_000...999_999))?.asString
    }
}
#endif
