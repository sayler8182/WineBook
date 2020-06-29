//
//  AboutUsPresenter.swift
//  WineBook
//
//  Created by Konrad on 6/25/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import UIKit

// MARK: AboutUsPresentationLogic
protocol AboutUsPresentationLogic {
    func presentContent(_ response: AboutUs.GetContent.Response)
}

// MARK: AboutUsPresenter
class AboutUsPresenter: AboutUsPresentationLogic {
    weak var controller: AboutUsDisplayLogic!
  
    func presentContent(_ response: AboutUs.GetContent.Response) {
        DispatchQueue.main.async {
            let viewModel = AboutUs.GetContent.ViewModel(
                image: response.image,
                description: response.description)
            self.controller.displayContent(viewModel)
        }
    }
}
