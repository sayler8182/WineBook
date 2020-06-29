//
//  ProfileWorker.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: ProfileWorker
class ProfileWorker {
    func profile(onSuccess: @escaping (ProfileResponse) -> Void,
                 onError: @escaping (NetworkError) -> Void) {
        NetworkMethods.profile.profile.get()
            .call(onSuccess: { (data: ProfileResponse) in
                onSuccess(data)
            }, onError: { (error) in
                onError(error)
            }, onCompletion: nil)
    }
    
    func profileSave(name: String?,
                     birthDate: String?,
                     phoneNumber: String?,
                     notifications: Bool?,
                     onSuccess: @escaping () -> Void,
                     onError: @escaping (NetworkError) -> Void) {
        let content = NetworkMethods.profile.profile.post.Content(
            name: name,
            birthDate: birthDate,
            phoneNumber: phoneNumber,
            notifications: notifications)
        NetworkMethods.profile.profile.post(content)
            .call(onSuccess: { _ in
                onSuccess()
            }, onError: { (error) in
                onError(error)
            }, onCompletion: nil)
    }
    
    func signOut(onSuccess: @escaping () -> Void,
                 onError: @escaping (NetworkError) -> Void) {
        Storage.token.remove()
    }
}
