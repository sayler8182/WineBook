//
//  PurchasesModels.swift
//  WineBook
//
//  Created by Konrad on 6/26/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsUtils
import Foundation

// MARK: Purchases
enum Purchases {
    enum GetContent {
        struct Request { }
        struct Response {
            let purchases: [PurchaseModel]
        }
        struct ViewModel {
            let totalAmount: String
            let purchases: [PurchaseCellModel]
        }
    }
    struct Error {
        let reason: String
    }
}

extension Purchases {
    struct PurchaseCellModel: PurchaseCellModelProtocol {
        var id: String
        var date: String?
        var items: String?
        var amount: String?
    }
}
