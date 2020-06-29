//
//  AboutUsModels.swift
//  WineBook
//
//  Created by Konrad on 6/25/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: AboutUs
enum AboutUs {
    enum GetContent {
        struct Request { }
        struct Response {
            let image: URL?
            let description: String?
        }
        struct ViewModel {
            let image: URL?
            let description: String?
        }
    }
}
