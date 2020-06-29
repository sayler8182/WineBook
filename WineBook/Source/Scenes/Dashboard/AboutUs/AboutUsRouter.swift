//
//  AboutUsRouter.swift
//  WineBook
//
//  Created by Konrad on 6/25/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsInjector
import UIKit

// MARK: AboutUsRoutingLogic
protocol AboutUsRoutingLogic { }

// MARK: AboutUsDataPassing
protocol AboutUsDataPassing {
    var dataStore: AboutUsDataStore! { get }
}

// MARK: AboutUsRouter
class AboutUsRouter: AboutUsRoutingLogic, AboutUsDataPassing {
    weak var controller: AboutUsViewController!
    var dataStore: AboutUsDataStore!
    private let injector: Injector = Forms.injector
}
