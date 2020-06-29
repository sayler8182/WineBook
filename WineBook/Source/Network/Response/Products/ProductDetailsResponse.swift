//
//  ProductDetailsResponse.swift
//  WineBook
//
//  Created by Konrad on 6/23/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: ProductDetailsResponse
class ProductDetailsResponse: Codable, Parseable {
    let product: ProductModel
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.product = try container.decode(ProductModel.self, forKey: .product)
    }
    
    enum CodingKeys: String, CodingKey {
        case product
    }
}
