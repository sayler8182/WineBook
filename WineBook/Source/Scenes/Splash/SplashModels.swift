//
//  SplashModels.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: Splash
enum Splash {
    enum GetContent {
        struct Request { }
        struct Response {
            let isSessionActive: Bool
        }
        struct ViewModel {
            let isSessionActive: Bool
        }
    }
}
