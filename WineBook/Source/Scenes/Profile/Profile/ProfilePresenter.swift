//
//  ProfilePresenter.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import UIKit

// MARK: ProfilePresentationLogic
protocol ProfilePresentationLogic {
    func presentContent(_ response: Profile.GetContent.Response)
    func presentContent(_ error: Profile.Error)
    func presentConfirm(_ response: Profile.Confirm.Response)
    func presentConfirm(_ error: Profile.Error)
    func presentSignOutConfirm(_ response: Profile.SignOutConfirm.Response)
    func presentSignOut(_ response: Profile.SignOut.Response)
    func presentSignOut(_ error: Profile.Error)
}

// MARK: ProfilePresenter
class ProfilePresenter: ProfilePresentationLogic {
    weak var controller: ProfileDisplayLogic!
  
    func presentContent(_ response: Profile.GetContent.Response) {
        DispatchQueue.main.async {
            let viewModel = Profile.GetContent.ViewModel(
                name: response.name,
                birthDate: response.birthDate,
                email: response.email,
                phoneNumber: response.phoneNumber,
                notifications: response.notifications)
            self.controller.displayContent(viewModel)
        }
    }
    
    func presentContent(_ error: Profile.Error) {
        DispatchQueue.main.async {
            self.controller.displayContent(error)
        }
    }
    
    func presentConfirm(_ response: Profile.Confirm.Response) {
        DispatchQueue.main.async {
            let viewModel = Profile.Confirm.ViewModel()
            self.controller.displayConfirm(viewModel)
        }
    }
    
    func presentConfirm(_ error: Profile.Error) {
        DispatchQueue.main.async {
            self.controller.displayConfirm(error)
        }
    }
    
    func presentSignOutConfirm(_ response: Profile.SignOutConfirm.Response) {
        DispatchQueue.main.async {
            let viewModel = Profile.SignOutConfirm.ViewModel()
            self.controller.displaySignOutConfirm(viewModel)
        }
    }
    
    func presentSignOut(_ response: Profile.SignOut.Response) {
        DispatchQueue.main.async {
            let viewModel = Profile.SignOut.ViewModel()
            self.controller.displaySignOut(viewModel)
        }
    }
    
    func presentSignOut(_ error: Profile.Error) {
        DispatchQueue.main.async {
            self.controller.displaySignOut(error)
        }
    }
}
