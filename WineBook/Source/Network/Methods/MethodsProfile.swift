//
//  MethodsProfile.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: NetworkMethodsProfile
enum NetworkMethodsProfile {
    class discount: NetworkMethod {
        var session: NetworkSessionProtocol? = FileNetworkSession(isEnabled: Bundle.main.isApiMocked)
        var url: URL! = NetworkMethods.baseURL.appending("/discount").url
        var interceptor: NetworkRequestInterceptor? = SessionNetworkRequestInterceptor()
    }
    
    enum profile {
        class get: NetworkMethod {
            var session: NetworkSessionProtocol? = FileNetworkSession(filename: "profile_get", isEnabled: Bundle.main.isApiMocked)
            var method: HTTPMethod = .GET
            var url: URL! = NetworkMethods.baseURL.appending("/profile").url
            var interceptor: NetworkRequestInterceptor? = SessionNetworkRequestInterceptor()
        }
        
        class post: NetworkMethod {
            struct Content: NetworkMethodContent {
                let name: String?
                let birthDate: String?
                let phoneNumber: String?
                let notifications: Bool?
                
                var parameters: [String: Any]? {
                    var parameters: [String: Any] = [:]
                    parameters["name"] = self.name
                    parameters["birthDate"] = self.birthDate
                    parameters["phoneNumber"] = self.phoneNumber
                    parameters["notifications"] = self.notifications
                    return parameters
                }
            }
            
            var content: NetworkMethodContent?
            var session: NetworkSessionProtocol? = FileNetworkSession(filename: "profile_post", isEnabled: Bundle.main.isApiMocked)
            var method: HTTPMethod = .POST
            var url: URL! = NetworkMethods.baseURL.appending("/profile").url
            var interceptor: NetworkRequestInterceptor? = SessionNetworkRequestInterceptor()
            
            init(_ content: Content) {
                self.content = content
            }
        }
    }
}
