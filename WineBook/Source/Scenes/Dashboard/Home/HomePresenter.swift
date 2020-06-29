//
//  HomePresenter.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import UIKit

// MARK: HomePresentationLogic
protocol HomePresentationLogic {
    func presentContent(_ response: Home.GetContent.Response)
    func presentContent(_ error: Home.Error)
    func presentResetContent(_ response: Home.ResetContent.Response)
    func presentDetails(_ response: Home.Details.Response)
}

// MARK: HomePresenter
class HomePresenter: HomePresentationLogic {
    weak var controller: HomeDisplayLogic!
  
    func presentContent(_ response: Home.GetContent.Response) {
        let products: [Home.ProductCellModel] = response.products
            .map { Home.ProductCellModel(model: $0) }
        DispatchQueue.main.async {
            let viewModel = Home.GetContent.ViewModel(
                products: products,
                isLast: response.isLast)
            self.controller.displayContent(viewModel)
        }
    }
    
    func presentContent(_ error: Home.Error) {
        DispatchQueue.main.async {
            self.controller.displayContent(error)
        }
    }
    
    func presentResetContent(_ response: Home.ResetContent.Response) {
        DispatchQueue.main.async {
            let viewModel = Home.ResetContent.ViewModel()
            self.controller.displayResetContent(viewModel)
        }
    }
    
    func presentDetails(_ response: Home.Details.Response) {
        DispatchQueue.main.async {
            let viewModel = Home.Details.ViewModel(
            productId: response.productId)
            self.controller.displayDetails(viewModel)
        }
    }
}

extension Home.ProductCellModel {
    init(model: ProductModel) {
        self.id = model.id
        self.image = model.image
        self.title = model.title
        self.description = model.description
    }
}
