//
//  ProductDetailsRouter.swift
//  WineBook
//
//  Created by Konrad on 6/23/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsInjector
import UIKit

// MARK: ProductDetailsRoutingLogic
protocol ProductDetailsRoutingLogic { }

// MARK: ProductDetailsDataPassing
protocol ProductDetailsDataPassing {
    var dataStore: ProductDetailsDataStore! { get }
}

// MARK: ProductDetailsRouter
class ProductDetailsRouter: ProductDetailsRoutingLogic, ProductDetailsDataPassing {
    weak var controller: ProductDetailsViewController!
    var dataStore: ProductDetailsDataStore!
    private let injector: Injector = Forms.injector
}
