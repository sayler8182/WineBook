//
//  NetworkMethodsContact.swift
//  WineBook
//
//  Created by Konrad on 6/25/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: NetworkMethodsContact
enum NetworkMethodsContact {
    class contact: NetworkMethod {
        struct Content: NetworkMethodContent {
            let message: String?
            
            var parameters: [String: Any]? {
                var parameters: [String: Any] = [:]
                parameters["message"] = self.message
                return parameters
            }
        }
        
        var content: NetworkMethodContent?
        var session: NetworkSessionProtocol? = FileNetworkSession(delay: 1.0)
        var method: HTTPMethod = .POST
        var url: URL! = NetworkMethods.baseURL.appending("/contact").url
        var interceptor: NetworkRequestInterceptor? = SessionNetworkRequestInterceptor()
        
        init(_ content: Content) {
            self.content = content
        }
    }
}
