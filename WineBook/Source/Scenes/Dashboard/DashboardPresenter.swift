//
//  DashboardPresenter.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import UIKit

// MARK: DashboardPresentationLogic
protocol DashboardPresentationLogic {
    func presentContent(_ response: Dashboard.GetContent.Response)
}

// MARK: DashboardPresenter
class DashboardPresenter: DashboardPresentationLogic {
    weak var controller: DashboardDisplayLogic!
  
    func presentContent(_ response: Dashboard.GetContent.Response) {
        DispatchQueue.asyncMainIfNeeded {
            let viewModel = Dashboard.GetContent.ViewModel()
            self.controller.displayContent(viewModel)
        }
    }
}
