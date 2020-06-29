//
//  LoginResponse.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: LoginResponse
class LoginResponse: Codable, Parseable {
    let token: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.token = try container.decode(String.self, forKey: .token)
    }
    
    enum CodingKeys: String, CodingKey {
        case token
    }
}
