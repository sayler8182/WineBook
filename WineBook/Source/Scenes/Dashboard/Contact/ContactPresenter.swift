//
//  ContactPresenter.swift
//  WineBook
//
//  Created by Konrad on 6/25/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import UIKit

// MARK: ContactPresentationLogic
protocol ContactPresentationLogic {
    func presentContent(_ response: Contact.GetContent.Response)
    func presentPhone(_ response: Contact.Phone.Response)
    func presentEmail(_ response: Contact.Email.Response)
    func presentAddress(_ response: Contact.Address.Response)
    func presentSend(_ response: Contact.Send.Response)
    func presentSend(_ error: Contact.Error)
}

// MARK: ContactPresenter
class ContactPresenter: ContactPresentationLogic {
    weak var controller: ContactDisplayLogic!
  
    func presentContent(_ response: Contact.GetContent.Response) {
        DispatchQueue.main.async {
            let viewModel = Contact.GetContent.ViewModel(
                phone: response.phone,
                email: response.email,
                address: response.address,
                map: response.map)
            self.controller.displayContent(viewModel)
        }
    }
    
    func presentPhone(_ response: Contact.Phone.Response) {
        DispatchQueue.main.async {
            let viewModel = Contact.Phone.ViewModel()
            self.controller.displayPhone(viewModel)
        }
    }
    
    func presentEmail(_ response: Contact.Email.Response) {
        DispatchQueue.main.async {
            let viewModel = Contact.Email.ViewModel()
            self.controller.displayEmail(viewModel)
        }
    }
    
    func presentAddress(_ response: Contact.Address.Response) {
        DispatchQueue.main.async {
            let viewModel = Contact.Address.ViewModel()
            self.controller.displayAddress(viewModel)
        }
    }
    
    func presentSend(_ response: Contact.Send.Response) {
        DispatchQueue.main.async {
            let viewModel = Contact.Send.ViewModel()
            self.controller.displaySend(viewModel)
        }
    }
    
    func presentSend(_ error: Contact.Error) {
        DispatchQueue.main.async {
            self.controller.displaySend(error)
        }
    }
}
