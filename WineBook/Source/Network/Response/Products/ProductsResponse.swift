//
//  ProductsResponse.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: ProductsResponse
class ProductsResponse: Codable, Parseable {
    let page: String?
    let nextPage: String?
    let products: [ProductModel]
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try? container.decode(String.self, forKey: .page)
        self.nextPage = try? container.decode(String.self, forKey: .nextPage)
        self.products = try container.decode([ProductModel].self, forKey: .products)
    }
    
    enum CodingKeys: String, CodingKey {
        case page
        case nextPage = "next_page"
        case products
    }
}
