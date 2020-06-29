//
//  LoginModels.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: Login
enum Login {
    enum GetContent {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    enum SignIn {
        enum WithApple {
            struct Request {
                let token: String
            }
            struct Response { }
            struct ViewModel { }
        }
        enum WithEmail {
            struct Request { }
            struct Response { }
            struct ViewModel { }
        }
        enum WithFacebook {
            struct Request {
                let token: String
            }
            struct Response { }
            struct ViewModel { }
        }
        enum WithGoogle {
            struct Request {
                let token: String
            }
            struct Response { }
            struct ViewModel { }
        }
    }
    struct Error {
        let reason: String
    }
}
