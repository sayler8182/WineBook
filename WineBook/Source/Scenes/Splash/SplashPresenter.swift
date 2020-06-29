//
//  SplashPresenter.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import UIKit

// MARK: SplashPresentationLogic
protocol SplashPresentationLogic {
    func presentContent(_ response: Splash.GetContent.Response)
}

// MARK: SplashPresenter
class SplashPresenter: SplashPresentationLogic {
    weak var controller: SplashDisplayLogic!
  
    func presentContent(_ response: Splash.GetContent.Response) {
        DispatchQueue.main.async {
            let viewModel = Splash.GetContent.ViewModel(
                isSessionActive: response.isSessionActive)
            self.controller.displayContent(viewModel)
        }
    }
}
