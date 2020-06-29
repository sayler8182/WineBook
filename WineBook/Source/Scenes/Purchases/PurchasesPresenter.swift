//
//  PurchasesPresenter.swift
//  WineBook
//
//  Created by Konrad on 6/26/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import UIKit

// MARK: PurchasesPresentationLogic
protocol PurchasesPresentationLogic {
    func presentContent(_ response: Purchases.GetContent.Response)
    func presentContent(_ error: Purchases.Error)
}

// MARK: PurchasesPresenter
class PurchasesPresenter: PurchasesPresentationLogic {
    weak var controller: PurchasesDisplayLogic!
  
    func presentContent(_ response: Purchases.GetContent.Response) {
        let totalAmount: String = response.purchases
            .compactMap { $0.amount }
            .reduce(0, +)
            .formatted(suffix: "$")
        let purchases: [Purchases.PurchaseCellModel] = response.purchases
            .map { Purchases.PurchaseCellModel(model: $0) }
        DispatchQueue.main.async {
            let viewModel = Purchases.GetContent.ViewModel(
                totalAmount: totalAmount,
                purchases: purchases)
            self.controller.displayContent(viewModel)
        }
    }
    
    func presentContent(_ error: Purchases.Error) {
        DispatchQueue.main.async {
            self.controller.displayContent(error)
        }
    }
}

extension Purchases.PurchaseCellModel {
    init(model: PurchaseModel) {
        self.id = model.id
        self.date = model.date
        let items: Int = model.items.or(0)
        self.items = "\(items) items"
        self.amount = model.amount?.formatted(suffix: "$")
    }
}
