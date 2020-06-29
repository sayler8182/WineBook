//
//  ProfileModels.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: Profile
enum Profile {
    enum GetContent {
        struct Request { }
        struct Response {
            let name: String?
            let birthDate: String?
            let email: String?
            let phoneNumber: String?
            let notifications: Bool?
        }
        struct ViewModel {
            let name: String?
            let birthDate: String?
            let email: String?
            let phoneNumber: String?
            let notifications: Bool?
        }
    }
    enum Confirm {
        struct Request {
            let name: String?
            let birthDate: String?
            let phoneNumber: String?
            let notifications: Bool?
        }
        struct Response { }
        struct ViewModel { }
    }
    enum SignOutConfirm {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    enum SignOut {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    struct Error {
        let reason: String
    }
}
