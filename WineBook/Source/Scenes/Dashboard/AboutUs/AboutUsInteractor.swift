//
//  AboutUsInteractor.swift
//  WineBook
//
//  Created by Konrad on 6/25/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsUtils
import Foundation

// MARK: AboutUsBusinessLogic
protocol AboutUsBusinessLogic {
    func getContent(_ request: AboutUs.GetContent.Request)
}

// MARK: AboutUsDataStore
protocol AboutUsDataStore {
}

// MARK: AboutUsInteractor
class AboutUsInteractor: AboutUsBusinessLogic, AboutUsDataStore {
    var presenter: AboutUsPresentationLogic!
    var worker: AboutUsWorker!

    let image: URL = "https://i.picsum.photos/id/29/1500/1500.jpg?hmac=068TqmV4_cmtYdFSr9fIJyyfwYEfGhfux5DahUcFjns".url
    let description: String = LoremIpsum.paragraph(sentences: 50)
    
    func getContent(_ request: AboutUs.GetContent.Request) {
        let response = AboutUs.GetContent.Response(
            image: self.image,
            description: self.description)
        self.presenter.presentContent(response)
    }
}
