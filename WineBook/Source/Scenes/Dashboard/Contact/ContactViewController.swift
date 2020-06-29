//
//  ContactViewController.swift
//  WineBook
//
//  Created by Konrad on 6/25/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsAnchor
import FormsNetworkingImage
import FormsToastKit
import FormsValidators
import UIKit

// MARK: ContactDisplayLogic
protocol ContactDisplayLogic: class {
    func displayContent(_ viewModel: Contact.GetContent.ViewModel)
    func displayPhone(_ viewModel: Contact.Phone.ViewModel)
    func displayEmail(_ viewModel: Contact.Email.ViewModel)
    func displayAddress(_ viewModel: Contact.Address.ViewModel)
    func displaySend(_ viewModel: Contact.Send.ViewModel)
    func displaySend(_ error: Contact.Error)
}

// MARK: ContactViewController
class ContactViewController: FormsTableViewController, ContactDisplayLogic {
    var interactor: ContactBusinessLogic!
    var router: (ContactRoutingLogic & ContactDataPassing)!

    private let navigationBar = Components.navigationBar.main()
    private let titleLabel = Components.label.title.big()
        .with(text: "Contact")
    private let subtitleLabel = Components.label.subtitle()
        .with(text: " ")
    private let phoneButton = Components.contact.contact()
        .with(icon: UIImage.from(name: "envelope"))
    private let emailButton = Components.contact.contact()
        .with(icon: UIImage.from(name: "envelope"))
    private let addressButton = Components.contact.contact()
        .with(icon: UIImage.from(name: "envelope"))
    private let mapView = Components.image.default()
        .with(anchors: { [Anchor.to($0).heightToWidth.multiplier(0.5)] })
        .with(contentMode: .scaleAspectFill)
        .with(isPreviewable: true)
        .with(isStopAutoShimmer: false)
        .with(marginTop: 16)
    private let messageInput = Components.input.textView.main()
        .with(title: "Write us")
        .with(validator: LengthValidator(minLength: 10, maxLength: 1_000))
    private let sendButton = Components.button.primary()
        .with(title: "Send")
    
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
            self.phoneButton,
            self.emailButton,
            self.addressButton,
            self.mapView,
            self.messageInput,
            self.sendButton
        ])
    }
    
    override func setupActions() {
        super.setupActions()
        self.phoneButton.onClick = { [unowned self] in
            self.phone()
        }
        self.emailButton.onClick = { [unowned self] in
            self.email()
        }
        self.addressButton.onClick = { [unowned self] in
            self.address()
        }
        self.sendButton.onClick = { [unowned self] in
            guard self.validateWithTrigger() else { return }
            self.dismissKeyboard()
            self.send()
        }
        self.messageInput.onTextChanged = { [unowned self] _ in
            guard self.messageInput.validateOnTextChange else { return }
            self.validate()
        }
        self.onValidate = { [unowned self] (result) in
            self.messageInput.validateOnTextChange = true
            self.sendButton.isEnabled = result
        }
    }
}

// MARK: ContactDisplayLogic - GetContent
extension ContactViewController {
    private func getContent() {
        let request = Contact.GetContent.Request()
        self.interactor.getContent(request)
    }

    func displayContent(_ viewModel: Contact.GetContent.ViewModel) {
        let request = NetworkImageRequest(url: viewModel.map)
            .with(isAutoShimmer: true)
            .with(scaleToFill: self.mapView.frame.size)
        self.mapView.setImage(request: request)
        self.phoneButton.title = viewModel.phone
        self.emailButton.title = viewModel.email
        self.addressButton.title = viewModel.address
    }
}

// MARK: ContactDisplayLogic - Phone
extension ContactViewController {
    private func phone() {
        let request = Contact.Phone.Request()
        self.interactor.phone(request)
    }

    func displayPhone(_ viewModel: Contact.Phone.ViewModel) {
        self.router.routeToPhone()
    }
}

// MARK: ContactDisplayLogic - Email
extension ContactViewController {
    private func email() {
        let request = Contact.Email.Request()
        self.interactor.email(request)
    }

    func displayEmail(_ viewModel: Contact.Email.ViewModel) {
        self.router.routeToEmail()
    }
}

// MARK: ContactDisplayLogic - Address
extension ContactViewController {
    private func address() {
        let request = Contact.Address.Request()
        self.interactor.address(request)
    }

    func displayAddress(_ viewModel: Contact.Address.ViewModel) {
        self.router.routeToAddress()
    }
}

// MARK: ContactDisplayLogic - Send
extension ContactViewController {
    private func send() {
        self.sendButton.startLoading()
        let request = Contact.Send.Request(
            message: self.messageInput.text)
        self.interactor.send(request)
    }

    func displaySend(_ viewModel: Contact.Send.ViewModel) {
        self.sendButton.stopLoading()
        self.sendButton.isEnabled = false
        Toast.success()
            .with(title: "Message has been sent")
            .show(in: self.navigationController)
    }
    
    func displaySend(_ error: Contact.Error) {
        self.sendButton.stopLoading()
        Toast.error()
            .with(title: error.reason)
            .show(in: self.navigationController)
    }
}
