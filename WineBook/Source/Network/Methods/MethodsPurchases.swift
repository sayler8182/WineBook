//
//  MethodsPurchases.swift
//  WineBook
//
//  Created by Konrad on 6/26/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: NetworkMethodsPurchases
enum NetworkMethodsPurchases {
    class purchases: NetworkMethod {
        var content: NetworkMethodContent?
        var session: NetworkSessionProtocol? = FileNetworkSession(isEnabled: Bundle.main.isApiMocked)
        var url: URL! = NetworkMethods.baseURL.appending("/purchases").url
        var interceptor: NetworkRequestInterceptor? = SessionNetworkRequestInterceptor()
    }
}
