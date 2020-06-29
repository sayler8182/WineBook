//
//  ContactInteractor.swift
//  WineBook
//
//  Created by Konrad on 6/25/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: ContactBusinessLogic
protocol ContactBusinessLogic {
    func getContent(_ request: Contact.GetContent.Request)
    func phone(_ request: Contact.Phone.Request)
    func email(_ request: Contact.Email.Request)
    func address(_ request: Contact.Address.Request)
    func send(_ request: Contact.Send.Request)
}

// MARK: ContactDataStore
protocol ContactDataStore {
    var phone: String { get }
    var email: String { get }
    var address: String { get }
}

// MARK: ContactInteractor
class ContactInteractor: ContactBusinessLogic, ContactDataStore {
    var presenter: ContactPresentationLogic!
    var worker: ContactWorker!
    
    let phone: String = "+48123456789"
    let email: String = "some@email.com"
    let address: String = "Some street 12/12, 00-000 Some City"
    let map: URL = "https://i.picsum.photos/id/29/1500/1500.jpg?hmac=068TqmV4_cmtYdFSr9fIJyyfwYEfGhfux5DahUcFjns".url
    
    func getContent(_ request: Contact.GetContent.Request) {
        let response = Contact.GetContent.Response(
            phone: self.phone,
            email: self.email,
            address: self.address,
            map: self.map)
        self.presenter.presentContent(response)
    }
    
    func phone(_ request: Contact.Phone.Request) {
        let response = Contact.Phone.Response()
        self.presenter.presentPhone(response)
    }
    
    func email(_ request: Contact.Email.Request) {
        let response = Contact.Email.Response()
        self.presenter.presentEmail(response)
    }
    
    func address(_ request: Contact.Address.Request) {
        let response = Contact.Address.Response()
        self.presenter.presentAddress(response)
    }
    
    func send(_ request: Contact.Send.Request) {
        self.worker.contact(
            message: request.message,
            onSuccess: { [weak self] in
                guard let `self` = self else { return }
                let response = Contact.Send.Response()
                self.presenter.presentSend(response)
        }, onError: { [weak self] (error) in
            guard let `self` = self else { return }
            let error = Contact.Error(reason: error.debugDescription)
            self.presenter.presentSend(error)
        })
    }
}
