//
//  DashboardInteractor.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: DashboardBusinessLogic
protocol DashboardBusinessLogic {
    func getContent(_ request: Dashboard.GetContent.Request)
}

// MARK: DashboardDataStore
protocol DashboardDataStore {
}

// MARK: DashboardInteractor
class DashboardInteractor: DashboardBusinessLogic, DashboardDataStore {
    var presenter: DashboardPresentationLogic!
    var worker: DashboardWorker!

    func getContent(_ request: Dashboard.GetContent.Request) {
        let response = Dashboard.GetContent.Response()
        self.presenter.presentContent(response)
    }
}
