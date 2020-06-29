//
//  HomeWorker.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: HomeWorker
class HomeWorker {
    func products(page: String?,
                  onSuccess: @escaping (ProductsResponse) -> Void,
                  onError: @escaping (NetworkError) -> Void) {
        let content = NetworkMethods.products.products.Content(
            page: page)
        NetworkMethods.products.products(content)
            .call(onSuccess: { (data: ProductsResponse) in
                onSuccess(data)
            }, onError: { (error) in
                onError(error)
            }, onCompletion: nil)
    }
}
