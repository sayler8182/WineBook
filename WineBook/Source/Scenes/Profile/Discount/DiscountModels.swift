//
//  DiscountModels.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: Discount
enum Discount {
    enum GetContent {
        struct Request { }
        struct Response {
            let code: String
        }
        struct ViewModel {
            let code: String
        }
    }
    struct Error {
        let reason: String
    }
}
