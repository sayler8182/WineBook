//
//  Storage.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsUtils
import Foundation

// MARK: StorageKey
enum StorageKey: String, FormsUtils.StorageKey {
    case token = "token"
}

// MARK: Storage
enum Storage {
    static var token: FormsUtils.StorageSecure<String> = .init(StorageKey.token)
}
