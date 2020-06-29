//
//  LoginWithEmailViewController.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsToastKit
import FormsValidators
import UIKit

// MARK: LoginWithEmailDisplayLogic
protocol LoginWithEmailDisplayLogic: class {
    func displayContent(_ viewModel: LoginWithEmail.GetContent.ViewModel)
    func displayConfirm(_ viewModel: LoginWithEmail.Confirm.ViewModel)
    func displayConfirm(_ error: LoginWithEmail.Error)
}

// MARK: LoginWithEmailViewController
class LoginWithEmailViewController: FormsTableViewController, LoginWithEmailDisplayLogic {
    var interactor: LoginWithEmailBusinessLogic!
    var router: (LoginWithEmailRoutingLogic & LoginWithEmailDataPassing)!

    private let navigationBar = Components.navigationBar.main()
    private let titleLabel = Components.label.title.auth()
        .with(text: "Authorization")
    private let subtitleLabel = Components.label.subtitle()
        .with(text: "Enter your email")
    private let emailInput = Components.input.textField.email.main()
        .with(title: "Email")
        .with(validator: EmailValidator())
    private let nextButton = Components.button.primary()
        .with(title: "Next")
    
    private var isFullValidation: Bool = false
    
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
            self.emailInput,
            self.nextButton
        ])
    }
    
    override func setupActions() {
        super.setupActions()
        self.nextButton.onClick = { [unowned self] in
            guard self.validateWithTrigger() else { return }
            self.dismissKeyboard()
            self.confirm()
        }
        self.emailInput.onTextChanged = { [unowned self] _ in
            guard self.emailInput.validateOnTextChange else { return }
            self.validate()
        }
        self.onValidate = { [unowned self] (result) in
            self.emailInput.validateOnTextChange = true
            self.nextButton.isEnabled = result
        }
    }
}

// MARK: LoginWithEmailDisplayLogic - GetContent
extension LoginWithEmailViewController {
    private func getContent() {
        let request = LoginWithEmail.GetContent.Request()
        self.interactor.getContent(request)
    }

    func displayContent(_ viewModel: LoginWithEmail.GetContent.ViewModel) { }
}

// MARK: LoginWithEmailDisplayLogic - Confirm
extension LoginWithEmailViewController {
    private func confirm() {
        self.nextButton.startLoading()
        let request = LoginWithEmail.Confirm.Request(
            email: self.emailInput.text)
        self.interactor.confirm(request)
    }

    func displayConfirm(_ viewModel: LoginWithEmail.Confirm.ViewModel) {
        self.nextButton.stopLoading()
        self.router.routeToLoginWithEmailCode()
    }
    
    func displayConfirm(_ error: LoginWithEmail.Error) {
        self.nextButton.stopLoading()
        Toast.error()
            .with(title: error.reason)
            .show(in: self.navigationController)
    }
}

#if DEBUG
import FormsMock
extension LoginWithEmailViewController {
    override func setupMock() {
        let mock = Mock()
        self.emailInput.text = mock.email()
    }
}
#endif
