//
//  PurchasesResponse.swift
//  WineBook
//
//  Created by Konrad on 6/26/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: PurchasesResponse
class PurchasesResponse: Codable, Parseable {
    let purchases: [PurchaseModel]
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.purchases = try container.decode([PurchaseModel].self, forKey: .purchases)
    }
    
    enum CodingKeys: String, CodingKey {
        case purchases
    }
}
