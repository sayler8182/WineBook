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
        var session: NetworkSessionProtocol? = FileNetworkSession(delay: 1.0)
        var url: URL! = NetworkMethods.baseURL.appending("/purchases").url
        var interceptor: NetworkRequestInterceptor? = SessionNetworkRequestInterceptor()
    }
}
