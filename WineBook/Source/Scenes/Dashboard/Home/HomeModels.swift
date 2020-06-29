//
//  HomeModels.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: Home
enum Home {
    enum GetContent {
        struct Request { }
        struct Response {
            let products: [ProductModel]
            let isLast: Bool
        }
        struct ViewModel {
            let products: [ProductCellModel]
            let isLast: Bool
        }
    }
    enum ResetContent {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    enum Details {
        struct Request {
            let productId: String
        }
        struct Response {
            let productId: String
        }
        struct ViewModel {
            let productId: String
        }
    }
    struct Error {
        let reason: String
    }
}

extension Home {
    struct ProductCellModel: ProductCellModelProtocol {
        var id: String
        var image: URL?
        var title: String?
        var description: String?
    }
}
