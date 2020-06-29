//
//  LoginWithEmailModels.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: LoginWithEmail
enum LoginWithEmail {
    enum GetContent {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    enum Confirm {
        struct Request {
            let email: String?
        }
        struct Response { }
        struct ViewModel { }
    }
    struct Error {
        let reason: String
    }
}
