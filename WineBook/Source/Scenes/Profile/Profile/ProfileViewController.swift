//
//  ProfileViewController.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsToastKit
import FormsValidators
import UIKit

// MARK: ProfileDisplayLogic
protocol ProfileDisplayLogic: class {
    func displayContent(_ viewModel: Profile.GetContent.ViewModel)
    func displayContent(_ error: Profile.Error)
    func displayConfirm(_ viewModel: Profile.Confirm.ViewModel)
    func displayConfirm(_ error: Profile.Error)
    func displaySignOutConfirm(_ viewModel: Profile.SignOutConfirm.ViewModel)
    func displaySignOut(_ viewModel: Profile.SignOut.ViewModel)
    func displaySignOut(_ error: Profile.Error)
}

// MARK: NotificationSegmentItem
private enum NotificationSegmentItem: Int, SegmentItem, CaseIterable {
    case on = 0
    case off = 1
    
    var title: String {
        switch self {
        case .on: return "On"
        case .off: return "Off"
        }
    }
}

// MARK: ProfileViewController
class ProfileViewController: FormsTableViewController, ProfileDisplayLogic {
    var interactor: ProfileBusinessLogic!
    var router: (ProfileRoutingLogic & ProfileDataPassing)!
    
    private let navigationBar = Components.navigationBar.main()
    private let titleLabel = Components.label.title.big()
        .with(text: "Profile")
    private let subtitleLabel = Components.label.subtitle()
        .with(text: " ")
    private let nameInput = Components.input.textField.main()
        .with(title: "Name")
        .with(validators: [
            StringValidator(set: .text),
            LengthValidator(minLength: 3, maxLength: 40)
        ])
        .with(validatorTriggered: true)
        .with(validateOnTextChange: true)
    private let birthDateInput = Components.input.textField.date.main()
        .with(title: "Date of birth")
        .with(validator: DateValidator())
        .with(validatorTriggered: true)
        .with(validateOnTextChange: true)
    private let emailInput = Components.input.textField.email.main()
        .with(isEnabled: false)
        .with(title: "Email")
        .with(validator: EmailValidator())
    private let phoneNumberInput = Components.input.textField.phone.main()
        .with(title: "Phone number")
        .with(validator: PhoneValidator())
        .with(validatorTriggered: true)
        .with(validateOnTextChange: true)
    private let notificationsLabel = Components.label.description()
        .with(text: "We will send you notifications when updated news about wines or notify you about other important account activity.")
    private lazy var notificationsSegment = Components.segment.default()
        .with(items: NotificationSegmentItem.allCases)
    private lazy var termsButton = Components.label.description()
        .with(sumMarginEdgeInset: UIEdgeInsets(vertical: 16))
        .with(text: "Terms and conditions")
    private let saveButton = Components.button.primary()
        .with(isEnabled: false)
        .with(title: "Save changes")
    private let signOutButton = Components.button.secondary()
        .with(title: "Sign Out")
    
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
            self.nameInput,
            self.birthDateInput,
            self.emailInput,
            self.phoneNumberInput,
            self.notificationsLabel,
            self.notificationsSegment,
            self.termsButton,
            self.saveButton,
            self.signOutButton
        ])
    }
    
    override func setupActions() {
        super.setupActions()
        self.saveButton.onClick = { [unowned self] in
            guard self.validateWithTrigger() else { return }
            self.dismissKeyboard()
            self.confirm()
        }
        self.signOutButton.onClick = { [unowned self] in
            self.signOut()
        }
        self.nameInput.onTextChanged = { [unowned self] _ in
            self.validate()
        }
        self.birthDateInput.onTextChanged = { [unowned self] _ in
            self.validate()
        }
        self.phoneNumberInput.onTextChanged = { [unowned self] _ in
            self.validate()
        }
        self.notificationsSegment.onValueChanged = { [unowned self] _ in
            self.validate()
        }
        self.onValidate = { [unowned self] (result) in
            self.saveButton.isEnabled = result
        }
    }
}

// MARK: ProfileDisplayLogic - GetContent
extension ProfileViewController {
    private func getContent() {
        self.startShimmering()
        let request = Profile.GetContent.Request()
        self.interactor.getContent(request)
    }
    
    func displayContent(_ viewModel: Profile.GetContent.ViewModel) {
        self.stopShimmering()
        let segment: SegmentItem = viewModel.notifications == true
            ? NotificationSegmentItem.on
            : NotificationSegmentItem.off
        self.nameInput.text = viewModel.name
        self.birthDateInput.text = viewModel.birthDate
        self.emailInput.text = viewModel.email
        self.phoneNumberInput.text = viewModel.phoneNumber
        self.notificationsSegment.selected = segment
    }
    
    func displayContent(_ error: Profile.Error) {
        self.stopShimmering()
        Toast.error()
            .with(title: error.reason)
            .show(in: self.navigationController)
    }
}

// MARK: ProfileDisplayLogic - Confirm
extension ProfileViewController {
    private func confirm() {
        self.saveButton.startLoading()
        let notifications: Bool = self.notificationsSegment.selected?.rawValue == NotificationSegmentItem.on.rawValue
        let request = Profile.Confirm.Request(
            name: self.nameInput.text,
            birthDate: self.birthDateInput.text,
            phoneNumber: self.phoneNumberInput.text,
            notifications: notifications)
        self.interactor.confirm(request)
    }
    
    func displayConfirm(_ viewModel: Profile.Confirm.ViewModel) {
        self.saveButton.stopLoading()
        Toast.success()
            .with(title: "Profile has been saved")
            .show(in: self.navigationController)
        self.saveButton.isEnabled = false
    }
    
    func displayConfirm(_ error: Profile.Error) {
        self.saveButton.stopLoading()
        Toast.error()
            .with(title: error.reason)
            .show(in: self.navigationController)
    }
}

// MARK: ProfileDisplayLogic - SignOutConfirm
extension ProfileViewController {
    private func signOutConfirm() {
        let request = Profile.SignOutConfirm.Request()
        self.interactor.signOutConfirm(request)
    }
    
    func displaySignOutConfirm(_ viewModel: Profile.SignOutConfirm.ViewModel) {
        UIAlertController()
            .with(title: "Attention!")
            .with(message: "Are you sure You want to logout?")
            .with(action: "Yes", style: .destructive, handler: { [unowned self] _ in
                self.signOut()
            })
            .with(action: "No", style: .cancel)
            .present(on: self)
    }
}

// MARK: ProfileDisplayLogic - SignOut
extension ProfileViewController {
    private func signOut() {
        self.signOutButton.startLoading()
        let request = Profile.SignOut.Request()
        self.interactor.signOut(request)
    }
    
    func displaySignOut(_ viewModel: Profile.SignOut.ViewModel) {
        self.signOutButton.stopLoading()
        self.router.routeToLogin()
    }
    
    func displaySignOut(_ error: Profile.Error) {
        self.signOutButton.stopLoading()
        Toast.error()
            .with(title: error.reason)
            .show(in: self.navigationController)
    }
}
