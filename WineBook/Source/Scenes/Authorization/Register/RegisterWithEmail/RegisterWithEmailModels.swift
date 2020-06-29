//
//  RegisterWithEmailModels.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: RegisterWithEmail
enum RegisterWithEmail {
    enum GetContent {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    enum SignUp {
        struct Request {
            let name: String?
            let birthDate: String?
            let password: String?
        }
        struct Response { }
        struct ViewModel { }
    }
    struct Error {
        let reason: String
    }
}
