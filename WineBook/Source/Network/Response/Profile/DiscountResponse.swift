//
//  DiscountResponse.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: DiscountResponse
class DiscountResponse: Codable, Parseable {
    let code: String
    let value: Int
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(String.self, forKey: .code)
        self.value = try container.decode(Int.self, forKey: .value)
    }
    
    enum CodingKeys: String, CodingKey {
        case code
        case value
    }
}
