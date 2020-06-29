//
//  DiscountRouter.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsInjector
import UIKit

// MARK: DiscountRoutingLogic
protocol DiscountRoutingLogic { }

// MARK: DiscountDataPassing
protocol DiscountDataPassing {
    var dataStore: DiscountDataStore! { get }
}

// MARK: DiscountRouter
class DiscountRouter: DiscountRoutingLogic, DiscountDataPassing {
    weak var controller: DiscountViewController!
    var dataStore: DiscountDataStore!
    private let injector: Injector = Forms.injector
}
