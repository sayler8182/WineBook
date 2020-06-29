//
//  MethodsProducts.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: NetworkMethodsProducts
enum NetworkMethodsProducts {
    class products: NetworkMethod {
        struct Content: NetworkMethodContent {
            let page: String?
            
            var parameters: [String: Any]? {
                var parameters: [String: Any] = [:]
                parameters["page"] = self.page
                return parameters
            }
        }
        
        var content: NetworkMethodContent?
        var session: NetworkSessionProtocol? = FileNetworkSession(delay: 1.0)
        var url: URL! = NetworkMethods.baseURL.appending("/products").url
        var interceptor: NetworkRequestInterceptor? = SessionNetworkRequestInterceptor()
        
        init(_ content: Content) {
            self.content = content
        }
    }
    
    class product: NetworkMethod {
        struct Content: NetworkMethodContent {
            let id: String?
            
            var parameters: [String: Any]? {
                let parameters: [String: Any] = [:]
                return parameters
            }
        }
        
        var content: NetworkMethodContent?
        var session: NetworkSessionProtocol? = FileNetworkSession(filename: "product", delay: 1.0)
        var url: URL! {
            let content: Content? = self.content as? Content
            let id: String = content?.id ?? ""
            return NetworkMethods.baseURL.appending("/product/\(id)").url
        }
        var interceptor: NetworkRequestInterceptor? = SessionNetworkRequestInterceptor()
        
        init(_ content: Content) {
            self.content = content
        }
    }
}
