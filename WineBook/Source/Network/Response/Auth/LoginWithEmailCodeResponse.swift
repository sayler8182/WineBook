//
//  LoginWithEmailCodeResponse.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: LoginWithEmailCodeResponse
class LoginWithEmailCodeResponse: Codable, Parseable {
    enum Mode: String, Codable {
        case USER_NOT_FOUND
        case USER_EXIST
    }
    
    let mode: Mode
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mode = try container.decode(Mode.self, forKey: .mode)
    }
    
    enum CodingKeys: String, CodingKey {
        case mode
    }
}
