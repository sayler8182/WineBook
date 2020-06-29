//
//  LoginWithEmailCodeModels.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: LoginWithEmailCode
enum LoginWithEmailCode {
    enum GetContent {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    enum Confirm {
        struct Request {
            let code: String?
        }
        struct Response {
            let isUserExist: Bool
        }
        struct ViewModel {
            let isUserExist: Bool
        }
    }
    struct Error {
        let reason: String
    }
}
