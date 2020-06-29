//
//  LoginWithEmailPasswordPresenter.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import UIKit

// MARK: LoginWithEmailPasswordPresentationLogic
protocol LoginWithEmailPasswordPresentationLogic {
    func presentContent(_ response: LoginWithEmailPassword.GetContent.Response)
    func presentConfirm(_ response: LoginWithEmailPassword.Confirm.Response)
    func presentConfirm(_ error: LoginWithEmailPassword.Error)
}

// MARK: LoginWithEmailPasswordPresenter
class LoginWithEmailPasswordPresenter: LoginWithEmailPasswordPresentationLogic {
    weak var controller: LoginWithEmailPasswordDisplayLogic!
  
    func presentContent(_ response: LoginWithEmailPassword.GetContent.Response) {
        DispatchQueue.main.async {
            let viewModel = LoginWithEmailPassword.GetContent.ViewModel()
            self.controller.displayContent(viewModel)
        }
    }
    
    func presentConfirm(_ response: LoginWithEmailPassword.Confirm.Response) {
        DispatchQueue.main.async {
            let viewModel = LoginWithEmailPassword.Confirm.ViewModel()
            self.controller.displayConfirm(viewModel)
        }
    }
    
    func presentConfirm(_ error: LoginWithEmailPassword.Error) {
        DispatchQueue.main.async {
            self.controller.displayConfirm(error)
        }
    }
}
