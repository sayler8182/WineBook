//
//  InfoPresenter.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import UIKit

// MARK: InfoPresentationLogic
protocol InfoPresentationLogic {
    func presentContent(_ response: Info.GetContent.Response)
}

// MARK: InfoPresenter
class InfoPresenter: InfoPresentationLogic {
    weak var controller: InfoDisplayLogic!
  
    func presentContent(_ response: Info.GetContent.Response) {
        DispatchQueue.main.async {
            let viewModel = Info.GetContent.ViewModel()
            self.controller.displayContent(viewModel)
        }
    }
}
