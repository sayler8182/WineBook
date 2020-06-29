//
//  PurchasesRouter.swift
//  WineBook
//
//  Created by Konrad on 6/26/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsInjector
import UIKit

// MARK: PurchasesRoutingLogic
protocol PurchasesRoutingLogic { }

// MARK: PurchasesDataPassing
protocol PurchasesDataPassing {
    var dataStore: PurchasesDataStore! { get }
}

// MARK: PurchasesRouter
class PurchasesRouter: PurchasesRoutingLogic, PurchasesDataPassing {
    weak var controller: PurchasesViewController!
    var dataStore: PurchasesDataStore!
    private let injector: Injector = Forms.injector
}
