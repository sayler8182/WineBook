//
//  ProfileInteractor.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: ProfileBusinessLogic
protocol ProfileBusinessLogic {
    func getContent(_ request: Profile.GetContent.Request)
    func confirm(_ request: Profile.Confirm.Request)
    func signOutConfirm(_ request: Profile.SignOutConfirm.Request)
    func signOut(_ request: Profile.SignOut.Request)
}

// MARK: ProfileDataStore
protocol ProfileDataStore {
}

// MARK: ProfileInteractor
class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    var presenter: ProfilePresentationLogic!
    var worker: ProfileWorker!

    func getContent(_ request: Profile.GetContent.Request) {
        self.worker.profile(
            onSuccess: { [weak self] (response: ProfileResponse) in
            guard let `self` = self else { return }
                let response = Profile.GetContent.Response(
                    name: response.name,
                    birthDate: response.birthDate,
                    email: response.email,
                    phoneNumber: response.phoneNumber,
                    notifications: response.notifications)
                self.presenter.presentContent(response)
        }, onError: { [weak self] (error) in
            guard let `self` = self else { return }
            let error = Profile.Error(reason: error.debugDescription)
            self.presenter.presentContent(error)
        })
    }
    
    func confirm(_ request: Profile.Confirm.Request) {
        self.worker.profileSave(
            name: request.name,
            birthDate: request.birthDate,
            phoneNumber: request.phoneNumber,
            notifications: request.notifications,
            onSuccess: { [weak self] in
            guard let `self` = self else { return }
                let response = Profile.Confirm.Response()
                self.presenter.presentConfirm(response)
        }, onError: { [weak self] (error) in
            guard let `self` = self else { return }
            let error = Profile.Error(reason: error.debugDescription)
            self.presenter.presentConfirm(error)
        })
    }
    
    func signOutConfirm(_ request: Profile.SignOutConfirm.Request) {
        let response = Profile.SignOutConfirm.Response()
        self.presenter.presentSignOutConfirm(response)
    }
    
    func signOut(_ request: Profile.SignOut.Request) {
        self.worker.signOut(
            onSuccess: { [weak self] in
                guard let `self` = self else { return }
                let response = Profile.SignOut.Response()
                self.presenter.presentSignOut(response)
        }, onError: { [weak self] _ in
            guard let `self` = self else { return }
            let response = Profile.SignOut.Response()
            self.presenter.presentSignOut(response)
        })
    }
}
