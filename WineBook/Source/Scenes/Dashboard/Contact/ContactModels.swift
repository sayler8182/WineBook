//
//  ContactModels.swift
//  WineBook
//
//  Created by Konrad on 6/25/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: Contact
enum Contact {
    enum GetContent {
        struct Request { }
        struct Response {
            let phone: String?
            let email: String?
            let address: String?
            let map: URL?
        }
        struct ViewModel {
            let phone: String?
            let email: String?
            let address: String?
            let map: URL?
        }
    }
    enum Phone {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    enum Email {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    enum Address {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    enum Send {
        struct Request {
            let message: String?
        }
        struct Response { }
        struct ViewModel { }
    }
    struct Error {
        let reason: String
    }
}
