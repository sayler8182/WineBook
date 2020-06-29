//
//  ProductModel.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: ProductModel
struct ProductModel: Codable {
    let id: String
    let image: URL?
    let title: String?
    let description: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.image = try? container.decode(URL.self, forKey: .image)
        self.title = try? container.decode(String.self, forKey: .title)
        self.description = try? container.decode(String.self, forKey: .description)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case image
        case title
        case description
    }
}
