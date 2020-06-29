//
//  ProductDetailsWorker.swift
//  WineBook
//
//  Created by Konrad on 6/23/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: ProductDetailsWorker
class ProductDetailsWorker {
    func product(id: String?,
                 onSuccess: @escaping (ProductDetailsResponse) -> Void,
                 onError: @escaping (NetworkError) -> Void) {
        let content = NetworkMethods.products.product.Content(
            id: id)
        NetworkMethods.products.product(content)
            .call(onSuccess: { (data: ProductDetailsResponse) in
                onSuccess(data)
            }, onError: { (error) in
                onError(error)
            }, onCompletion: nil)
    }
}
