//
//  ProductDetailsModels.swift
//  WineBook
//
//  Created by Konrad on 6/23/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: ProductDetails
enum ProductDetails {
    enum GetContent {
        struct Request { }
        struct Response {
            let image: URL?
            let title: String?
            let description: String?
        }
        struct ViewModel {
            let image: URL?
            let title: String?
            let description: String?
        }
    }
    struct Error {
        let reason: String
    }
}
