//
//  Methods.swift
//  WineBook
//
//  Created by Konrad on 6/21/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsInjector
import FormsNetworking

// MARK: NetworkMethods
enum NetworkMethods {
    typealias auth = NetworkMethodsAuth
    typealias contact = NetworkMethodsContact
    typealias products = NetworkMethodsProducts
    typealias profile = NetworkMethodsProfile
    typealias purchases = NetworkMethodsPurchases
    
    fileprivate static var baseURLKey: String = "_baseURLKey"
    static var baseURL: String {
        let baseURL: String? = Injector.main.resolve(Self.baseURLKey)
        return baseURL ?? ""
    }
}

// MARK: NetworkAssembly
struct NetworkAssembly: Assembly {
    func assemble(injector: Injector) {
        injector.register(String.self, name: NetworkMethods.baseURLKey) { _ in
            "localhost://api"
        }
    }
}
