//
//  SessionNetworkRequestInterceptor.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: SessionNetworkRequestInterceptor
class SessionNetworkRequestInterceptor: NetworkRequestInterceptor {
    override func setHeaders(_ request: NetworkRequest) {
        var headers: [String: String] = request.headers ?? [:]
        let token: String = Storage.token.value ?? ""
        headers["Authorization"] = "Bearer \(token)"
        request.request?.allHTTPHeaderFields = headers
    }
}
