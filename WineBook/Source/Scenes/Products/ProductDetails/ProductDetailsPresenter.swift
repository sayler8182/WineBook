//
//  ProductDetailsPresenter.swift
//  WineBook
//
//  Created by Konrad on 6/23/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import UIKit

// MARK: ProductDetailsPresentationLogic
protocol ProductDetailsPresentationLogic {
    func presentContent(_ response: ProductDetails.GetContent.Response)
    func presentContent(_ error: ProductDetails.Error)
}

// MARK: ProductDetailsPresenter
class ProductDetailsPresenter: ProductDetailsPresentationLogic {
    weak var controller: ProductDetailsDisplayLogic!
  
    func presentContent(_ response: ProductDetails.GetContent.Response) {
        DispatchQueue.main.async {
            let viewModel = ProductDetails.GetContent.ViewModel(
                image: response.image,
                title: response.title,
                description: response.description)
            self.controller.displayContent(viewModel)
        }
    }
    
    func presentContent(_ error: ProductDetails.Error) {
        DispatchQueue.main.async {
            self.controller.displayContent(error)
        }
    }
}
