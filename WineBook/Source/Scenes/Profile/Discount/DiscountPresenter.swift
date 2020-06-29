//
//  DiscountPresenter.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import UIKit

// MARK: DiscountPresentationLogic
protocol DiscountPresentationLogic {
    func presentContent(_ response: Discount.GetContent.Response)
    func presentContent(_ error: Discount.Error)
}

// MARK: DiscountPresenter
class DiscountPresenter: DiscountPresentationLogic {
    weak var controller: DiscountDisplayLogic!
  
    func presentContent(_ response: Discount.GetContent.Response) {
        DispatchQueue.main.async {
            let viewModel = Discount.GetContent.ViewModel(
                code: response.code)
            self.controller.displayContent(viewModel)
        }
    }
    
    func presentContent(_ error: Discount.Error) {
        DispatchQueue.main.async {
            self.controller.displayContent(error)
        }
    }
}
