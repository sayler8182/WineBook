//
//  LoginWithEmailCodePresenter.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import UIKit

// MARK: LoginWithEmailCodePresentationLogic
protocol LoginWithEmailCodePresentationLogic {
    func presentContent(_ response: LoginWithEmailCode.GetContent.Response)
    func presentConfirm(_ response: LoginWithEmailCode.Confirm.Response)
    func presentConfirm(_ error: LoginWithEmailCode.Error)
}

// MARK: LoginWithEmailCodePresenter
class LoginWithEmailCodePresenter: LoginWithEmailCodePresentationLogic {
    weak var controller: LoginWithEmailCodeDisplayLogic!
  
    func presentContent(_ response: LoginWithEmailCode.GetContent.Response) {
        DispatchQueue.main.async {
            let viewModel = LoginWithEmailCode.GetContent.ViewModel()
            self.controller.displayContent(viewModel)
        }
    }
    
    func presentConfirm(_ response: LoginWithEmailCode.Confirm.Response) {
        DispatchQueue.main.async {
            let viewModel = LoginWithEmailCode.Confirm.ViewModel(
                isUserExist: response.isUserExist)
            self.controller.displayConfirm(viewModel)
        }
    }
    
    func presentConfirm(_ error: LoginWithEmailCode.Error) {
        DispatchQueue.main.async {
            self.controller.displayConfirm(error)
        }
    }
}
