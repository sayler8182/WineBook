//
//  HomeInteractor.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsUtils
import Foundation

// MARK: HomeBusinessLogic
protocol HomeBusinessLogic {
    func getContent(_ request: Home.GetContent.Request)
    func resetContent(_ request: Home.ResetContent.Request)
    func details(_ request: Home.Details.Request)
}

// MARK: HomeDataStore
protocol HomeDataStore {
    var productId: String? { get }
}

// MARK: HomeInteractor
class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic!
    var worker: HomeWorker!

    var productId: String? = nil
    
    private let pagination = Pagination(
        of: ProductsResponse.self,
        firstPageId: String?.none,
        onNextPageId: { (_, page) in page?.data?.nextPage })
    
    func getContent(_ request: Home.GetContent.Request) {
        let page: String? = self.pagination.startLoading()
        self.worker.products(
            page: page,
            onSuccess: { [weak self] (response: ProductsResponse) in
                guard let `self` = self else { return }
                let isLast: Bool = false
                let page = Page(
                    pageId: page,
                    data: response,
                    isLast: isLast)
                self.pagination.stopLoading(page)
                let response = Home.GetContent.Response(
                    products: response.products,
                    isLast: isLast)
                self.presenter.presentContent(response)
            }, onError: { [weak self] (error) in
                guard let `self` = self else { return }
                let page = Page(
                    pageId: page,
                    data: ProductsResponse?.none,
                    error: error)
                self.pagination.stopLoading(page)
                let error = Home.Error(reason: error.debugDescription)
                self.presenter.presentContent(error)
        })
    }
    
    func resetContent(_ request: Home.ResetContent.Request) {
        self.pagination.reset()
        let response = Home.ResetContent.Response()
        self.presenter.presentResetContent(response)
    }
    
    func details(_ request: Home.Details.Request) {
        self.productId = request.productId
        let response = Home.Details.Response(
            productId: request.productId)
        self.presenter.presentDetails(response)
    }
}
