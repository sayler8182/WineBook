//
//  RegisterWithEmailPresenter.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import UIKit

// MARK: RegisterWithEmailPresentationLogic
protocol RegisterWithEmailPresentationLogic {
    func presentContent(_ response: RegisterWithEmail.GetContent.Response)
    func presentSignUp(_ response: RegisterWithEmail.SignUp.Response)
    func presentSignUp(_ error: RegisterWithEmail.Error)
}

// MARK: RegisterWithEmailPresenter
class RegisterWithEmailPresenter: RegisterWithEmailPresentationLogic {
    weak var controller: RegisterWithEmailDisplayLogic!
  
    func presentContent(_ response: RegisterWithEmail.GetContent.Response) {
        DispatchQueue.main.async {
            let viewModel = RegisterWithEmail.GetContent.ViewModel()
            self.controller.displayContent(viewModel)
        }
    }
    
    func presentSignUp(_ response: RegisterWithEmail.SignUp.Response) {
        DispatchQueue.main.async {
            let viewModel = RegisterWithEmail.SignUp.ViewModel()
            self.controller.displaySignUp(viewModel)
        }
    }
    
    func presentSignUp(_ error: RegisterWithEmail.Error) {
        DispatchQueue.main.async {
            self.controller.displaySignUp(error)
        }
    }
}
