//
//  MethodsAuth.swift
//  WineBook
//
//  Created by Konrad on 6/21/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: NetworkMethodsAuth
enum NetworkMethodsAuth {
    class signInWithApple: NetworkMethod {
        struct Content: NetworkMethodContent {
            let token: String
            
            var parameters: [String: Any]? {
                var parameters: [String: Any] = [:]
                parameters["token"] = self.token
                return parameters
            }
        }
        
        var content: NetworkMethodContent? = nil
        var session: NetworkSessionProtocol? = FileNetworkSession()
        var url: URL! = NetworkMethods.baseURL.appending("/signInWithApple").url
        
        init(_ content: Content) {
            self.content = content
        }
    }
    
    class signInWithEmail: NetworkMethod {
        struct Content: NetworkMethodContent {
            let email: String
            
            var parameters: [String: Any]? {
                var parameters: [String: Any] = [:]
                parameters["email"] = self.email
                return parameters
            }
        }
        
        var content: NetworkMethodContent? = nil
        var session: NetworkSessionProtocol? = FileNetworkSession()
        var url: URL! = NetworkMethods.baseURL.appending("/signInWithEmail").url
        
        init(_ content: Content) {
            self.content = content
        }
    }
    
    class signInWithEmailCode: NetworkMethod {
        struct Content: NetworkMethodContent {
            let email: String
            let code: String
            
            var parameters: [String: Any]? {
                var parameters: [String: Any] = [:]
                parameters["email"] = self.email
                parameters["code"] = self.code
                return parameters
            }
        }
        
        var content: NetworkMethodContent? = nil
        var session: NetworkSessionProtocol? = FileNetworkSession(filename: "signInWithEmailCode")
        var url: URL! = NetworkMethods.baseURL.appending("/signInWithEmail/code").url
        
        init(_ content: Content) {
            self.content = content
        }
    }
    
    class signInWithEmailPassword: NetworkMethod {
        struct Content: NetworkMethodContent {
            let email: String
            let code: String
            let password: String
            
            var parameters: [String: Any]? {
                var parameters: [String: Any] = [:]
                parameters["email"] = self.email
                parameters["code"] = self.code
                parameters["password"] = self.password
                return parameters
            }
        }
        
        var content: NetworkMethodContent? = nil
        var session: NetworkSessionProtocol? = FileNetworkSession(filename: "signInWithEmailPassword")
        var url: URL! = NetworkMethods.baseURL.appending("/signInWithEmail/password").url
        
        init(_ content: Content) {
            self.content = content
        }
    }
    
    class signInWithFacebook: NetworkMethod {
        struct Content: NetworkMethodContent {
            let token: String
            
            var parameters: [String: Any]? {
                var parameters: [String: Any] = [:]
                parameters["token"] = self.token
                return parameters
            }
        }
        
        var content: NetworkMethodContent? = nil
        var session: NetworkSessionProtocol? = FileNetworkSession()
        var url: URL! = NetworkMethods.baseURL.appending("/signInWithFacebook").url
        
        init(_ content: Content) {
            self.content = content
        }
    }
    
    class signInWithGoogle: NetworkMethod {
        struct Content: NetworkMethodContent {
            let token: String
            
            var parameters: [String: Any]? {
                var parameters: [String: Any] = [:]
                parameters["token"] = self.token
                return parameters
            }
        }
        
        var content: NetworkMethodContent? = nil
        var session: NetworkSessionProtocol? = FileNetworkSession()
        var url: URL! = NetworkMethods.baseURL.appending("/signInWithGoogle").url
        
        init(_ content: Content) {
            self.content = content
        }
    }
    
    class signUpWithEmail: NetworkMethod {
        struct Content: NetworkMethodContent {
            let email: String
            let name: String
            let code: String
            let birthDate: String
            let password: String
            
            var parameters: [String: Any]? {
                var parameters: [String: Any] = [:]
                parameters["email"] = self.email
                parameters["name"] = self.name
                parameters["code"] = self.code
                parameters["birthDate"] = self.birthDate
                parameters["password"] = self.password
                return parameters
            }
        }
        
        var content: NetworkMethodContent? = nil
        var session: NetworkSessionProtocol? = FileNetworkSession()
        var url: URL! = NetworkMethods.baseURL.appending("/signUpWithEmail").url
        
        init(_ content: Content) {
            self.content = content
        }
    }
}
