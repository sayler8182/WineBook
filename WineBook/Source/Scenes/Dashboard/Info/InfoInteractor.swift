//
//  InfoInteractor.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: InfoBusinessLogic
protocol InfoBusinessLogic {
    func getContent(_ request: Info.GetContent.Request)
}

// MARK: InfoDataStore
protocol InfoDataStore {
}

// MARK: InfoInteractor
class InfoInteractor: InfoBusinessLogic, InfoDataStore {
    var presenter: InfoPresentationLogic!
    var worker: InfoWorker!

    func getContent(_ request: Info.GetContent.Request) {
        let response = Info.GetContent.Response()
        self.presenter.presentContent(response)
    }
}
