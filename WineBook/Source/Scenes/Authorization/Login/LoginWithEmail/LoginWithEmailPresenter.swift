//
//  LoginWithEmailPresenter.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import UIKit

// MARK: LoginWithEmailPresentationLogic
protocol LoginWithEmailPresentationLogic {
    func presentContent(_ response: LoginWithEmail.GetContent.Response)
    func presentConfirm(_ response: LoginWithEmail.Confirm.Response)
    func presentConfirm(_ error: LoginWithEmail.Error)
}

// MARK: LoginWithEmailPresenter
class LoginWithEmailPresenter: LoginWithEmailPresentationLogic {
    weak var controller: LoginWithEmailDisplayLogic!
  
    func presentContent(_ response: LoginWithEmail.GetContent.Response) {
        DispatchQueue.main.async {
            let viewModel = LoginWithEmail.GetContent.ViewModel()
            self.controller.displayContent(viewModel)
        }
    }
    
    func presentConfirm(_ response: LoginWithEmail.Confirm.Response) {
        DispatchQueue.main.async {
            let viewModel = LoginWithEmail.Confirm.ViewModel()
            self.controller.displayConfirm(viewModel)
        }
    }
    
    func presentConfirm(_ error: LoginWithEmail.Error) {
        DispatchQueue.main.async {
            self.controller.displayConfirm(error)
        }
    }
}
