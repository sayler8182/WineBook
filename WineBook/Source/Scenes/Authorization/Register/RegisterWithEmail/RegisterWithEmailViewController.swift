//
//  RegisterWithEmailViewController.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsToastKit
import FormsValidators
import UIKit

// MARK: RegisterWithEmailDisplayLogic
protocol RegisterWithEmailDisplayLogic: class {
    func displayContent(_ viewModel: RegisterWithEmail.GetContent.ViewModel)
    func displaySignUp(_ viewModel: RegisterWithEmail.SignUp.ViewModel)
    func displaySignUp(_ error: RegisterWithEmail.Error)
}

// MARK: RegisterWithEmailViewController
class RegisterWithEmailViewController: FormsTableViewController, RegisterWithEmailDisplayLogic {
    var interactor: RegisterWithEmailBusinessLogic!
    var router: (RegisterWithEmailRoutingLogic & RegisterWithEmailDataPassing)!

    private let navigationBar = Components.navigationBar.main()
    private let titleLabel = Components.label.title.auth()
        .with(text: "Sign up")
    private let subtitleLabel = Components.label.subtitle()
        .with(text: " ")
    private let nameInput = Components.input.textField.main()
        .with(title: "Name")
        .with(validators: [
            StringValidator(set: .text),
            LengthValidator(minLength: 3, maxLength: 40)
        ])
    private let birthDateInput = Components.input.textField.date.main()
        .with(title: "Date of birth")
        .with(validator: DateValidator())
    private let passwordInput = Components.input.textField.password.main()
        .with(title: "Password")
        .with(validator: PasswordValidator())
    private let signUpButton = Components.button.primary()
        .with(title: "Sign up")
    
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
            self.nameInput,
            self.birthDateInput,
            self.passwordInput,
            self.signUpButton
        ])
    }
    
    override func setupActions() {
        super.setupActions()
        self.signUpButton.onClick = { [unowned self] in
            guard self.validateWithTrigger() else { return }
            self.dismissKeyboard()
            self.signUp()
        }
        self.nameInput.onTextChanged = { [unowned self] _ in
            guard self.nameInput.validateOnTextChange else { return }
            self.validate()
        }
        self.birthDateInput.onTextChanged = { [unowned self] _ in
            guard self.birthDateInput.validateOnTextChange else { return }
            self.validate()
        }
        self.passwordInput.onTextChanged = { [unowned self] _ in
            guard self.passwordInput.validateOnTextChange else { return }
            self.validate()
        }
        self.onValidate = { [unowned self] (result) in
            self.nameInput.validateOnTextChange = true
            self.birthDateInput.validateOnTextChange = true
            self.passwordInput.validateOnTextChange = true
            self.signUpButton.isEnabled = result
        }
    }
}

// MARK: RegisterWithEmailDisplayLogic - GetContent
extension RegisterWithEmailViewController {
    private func getContent() {
        let request = RegisterWithEmail.GetContent.Request()
        self.interactor.getContent(request)
    }

    func displayContent(_ viewModel: RegisterWithEmail.GetContent.ViewModel) { }
}

// MARK: RegisterWithEmailDisplayLogic - SignUp
extension RegisterWithEmailViewController {
    private func signUp() {
        self.signUpButton.startLoading()
        let request = RegisterWithEmail.SignUp.Request(
            name: self.nameInput.text,
            birthDate: self.birthDateInput.text,
            password: self.passwordInput.text)
        self.interactor.signUp(request)
    }

    func displaySignUp(_ viewModel: RegisterWithEmail.SignUp.ViewModel) {
        self.signUpButton.stopLoading()
        self.router.routeToDashboard()
    }
    
    func displaySignUp(_ error: RegisterWithEmail.Error) {
        self.signUpButton.stopLoading()
        Toast.error()
            .with(title: error.reason)
            .show(in: self.navigationController)
    }
}

#if DEBUG
import FormsMock
extension RegisterWithEmailViewController {
    override func setupMock() {
        let mock = Mock()
        self.nameInput.text = mock.name()
        self.birthDateInput.text = mock.date(from: "1920/01/01", to: "2000/01/01")?
            .formatted(format: "dd/MM/yyyy")
        self.passwordInput.text = mock.password()
    }
}
#endif
