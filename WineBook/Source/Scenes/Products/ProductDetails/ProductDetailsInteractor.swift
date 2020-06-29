//
//  ProductDetailsInteractor.swift
//  WineBook
//
//  Created by Konrad on 6/23/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: ProductDetailsBusinessLogic
protocol ProductDetailsBusinessLogic {
    func getContent(_ request: ProductDetails.GetContent.Request)
}

// MARK: ProductDetailsDataStore
protocol ProductDetailsDataStore {
    var productId: String? { get set }
}

// MARK: ProductDetailsInteractor
class ProductDetailsInteractor: ProductDetailsBusinessLogic, ProductDetailsDataStore {
    var presenter: ProductDetailsPresentationLogic!
    var worker: ProductDetailsWorker!

    var productId: String? = nil
    
    func getContent(_ request: ProductDetails.GetContent.Request) {
        self.worker.product(
            id: self.productId,
            onSuccess: { [weak self] (response: ProductDetailsResponse) in
                guard let `self` = self else { return }
                let response = ProductDetails.GetContent.Response(
                    image: response.product.image,
                    title: response.product.title,
                    description: response.product.description)
                self.presenter.presentContent(response)
        }, onError: { [weak self] (error) in
            guard let `self` = self else { return }
            let error = ProductDetails.Error(reason: error.debugDescription)
            self.presenter.presentContent(error)
        })
    }
}
