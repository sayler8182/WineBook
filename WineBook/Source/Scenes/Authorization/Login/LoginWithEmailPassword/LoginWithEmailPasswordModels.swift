//
//  LoginWithEmailPasswordModels.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: LoginWithEmailPassword
enum LoginWithEmailPassword {
    enum GetContent {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    enum Confirm {
        struct Request {
            let password: String?
        }
        struct Response { }
        struct ViewModel { }
    }
    struct Error {
        let reason: String
    }
}
