//
//  DiscountInteractor.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: DiscountBusinessLogic
protocol DiscountBusinessLogic {
    func getContent(_ request: Discount.GetContent.Request)
}

// MARK: DiscountDataStore
protocol DiscountDataStore {
}

// MARK: DiscountInteractor
class DiscountInteractor: DiscountBusinessLogic, DiscountDataStore {
    var presenter: DiscountPresentationLogic!
    var worker: DiscountWorker!

    func getContent(_ request: Discount.GetContent.Request) {
        self.worker.discount(
            onSuccess: { [weak self] (response: DiscountResponse) in
                guard let `self` = self else { return }
                let response = Discount.GetContent.Response(
                    code: response.code)
                self.presenter.presentContent(response)
            },
            onError: { [weak self] (error) in
                guard let `self` = self else { return }
                let error = Discount.Error(reason: error.debugDescription)
                self.presenter.presentContent(error)
        })
    }
}
