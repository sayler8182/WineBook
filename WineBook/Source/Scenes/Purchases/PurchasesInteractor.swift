//
//  PurchasesInteractor.swift
//  WineBook
//
//  Created by Konrad on 6/26/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: PurchasesBusinessLogic
protocol PurchasesBusinessLogic {
    func getContent(_ request: Purchases.GetContent.Request)
}

// MARK: PurchasesDataStore
protocol PurchasesDataStore {
}

// MARK: PurchasesInteractor
class PurchasesInteractor: PurchasesBusinessLogic, PurchasesDataStore {
    var presenter: PurchasesPresentationLogic!
    var worker: PurchasesWorker!

    func getContent(_ request: Purchases.GetContent.Request) {
        self.worker.purchases(onSuccess: { [weak self] (response: PurchasesResponse) in
            guard let `self` = self else { return }
            let response = Purchases.GetContent.Response(
                purchases: response.purchases)
            self.presenter.presentContent(response)
        }, onError: { [weak self] (error) in
            guard let `self` = self else { return }
            let error = Purchases.Error(reason: error.debugDescription)
            self.presenter.presentContent(error)
        })
    }
}
