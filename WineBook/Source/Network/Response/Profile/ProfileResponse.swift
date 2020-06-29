//
//  ProfileResponse.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: ProfileResponse
class ProfileResponse: Codable, Parseable {
    let name: String
    let birthDate: String
    let email: String
    let phoneNumber: String
    let notifications: Bool
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.birthDate = try container.decode(String.self, forKey: .birthDate)
        self.email = try container.decode(String.self, forKey: .email)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.notifications = try container.decode(Bool.self, forKey: .notifications)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case birthDate
        case email
        case phoneNumber
        case notifications
    }
}
