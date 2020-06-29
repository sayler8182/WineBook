//
//  LoginPresenter.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import UIKit

// MARK: LoginPresentationLogic
protocol LoginPresentationLogic {
    func presentContent(_ response: Login.GetContent.Response)
    func presentSignInWithApple(_ response: Login.SignIn.WithApple.Response)
    func presentSignInWithApple(_ error: Login.Error)
    func presentSignInWithEmail(_ response: Login.SignIn.WithEmail.Response)
    func presentSignInWithFacebook(_ response: Login.SignIn.WithFacebook.Response)
    func presentSignInWithFacebook(_ error: Login.Error)
    func presentSignInWithGoogle(_ response: Login.SignIn.WithGoogle.Response)
    func presentSignInWithGoogle(_ error: Login.Error)
}

// MARK: LoginPresenter
class LoginPresenter: LoginPresentationLogic {
    weak var controller: LoginDisplayLogic!
  
    func presentContent(_ response: Login.GetContent.Response) {
        DispatchQueue.main.async {
            let viewModel = Login.GetContent.ViewModel()
            self.controller.displayContent(viewModel)
        }
    }
    
    func presentSignInWithApple(_ response: Login.SignIn.WithApple.Response) {
        DispatchQueue.main.async {
            let viewModel = Login.SignIn.WithApple.ViewModel()
            self.controller.displaySignInWithApple(viewModel)
        }
    }
    
    func presentSignInWithApple(_ error: Login.Error) {
        DispatchQueue.main.async {
            self.controller.displaySignInWithApple(error)
        }
    }
    
    func presentSignInWithEmail(_ response: Login.SignIn.WithEmail.Response) {
        DispatchQueue.main.async {
            let viewModel = Login.SignIn.WithEmail.ViewModel()
            self.controller.displaySignInWithEmail(viewModel)
        }
    } 
    
    func presentSignInWithFacebook(_ response: Login.SignIn.WithFacebook.Response) {
        DispatchQueue.main.async {
            let viewModel = Login.SignIn.WithFacebook.ViewModel()
            self.controller.displaySignInWithFacebook(viewModel)
        }
    }
    
    func presentSignInWithFacebook(_ error: Login.Error) {
        DispatchQueue.main.async {
            self.controller.displaySignInWithFacebook(error)
        }
    }
    
    func presentSignInWithGoogle(_ response: Login.SignIn.WithGoogle.Response) {
        DispatchQueue.main.async {
            let viewModel = Login.SignIn.WithGoogle.ViewModel()
            self.controller.displaySignInWithGoogle(viewModel)
        }
    }
    
    func presentSignInWithGoogle(_ error: Login.Error) {
        DispatchQueue.main.async {
            self.controller.displaySignInWithGoogle(error)
        }
    }
}
