//
//  PurchaseModel.swift
//  WineBook
//
//  Created by Konrad on 6/26/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: PurchaseModel
struct PurchaseModel: Codable {
    let id: String
    let date: String?
    let items: Int?
    let amount: Double?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.date = try? container.decode(String.self, forKey: .date)
        self.items = try? container.decode(Int.self, forKey: .items)
        self.amount = try? container.decode(Double.self, forKey: .amount)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case items
        case amount
    }
}
