//
//  SplashInteractor.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Foundation

// MARK: SplashBusinessLogic
protocol SplashBusinessLogic {
    func getContent(_ request: Splash.GetContent.Request)
}

// MARK: SplashDataStore
protocol SplashDataStore {
}

// MARK: SplashInteractor
class SplashInteractor: SplashBusinessLogic, SplashDataStore {
    var presenter: SplashPresentationLogic!
    var worker: SplashWorker!

    func getContent(_ request: Splash.GetContent.Request) {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 1.0) {
            let isSessionActive: Bool = Storage.token.value.isNotNilOrEmpty
            let response = Splash.GetContent.Response(
                isSessionActive: isSessionActive)
            self.presenter.presentContent(response)
        }
    }
}
