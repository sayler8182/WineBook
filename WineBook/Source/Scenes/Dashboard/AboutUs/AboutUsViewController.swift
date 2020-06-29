//
//  AboutUsViewController.swift
//  WineBook
//
//  Created by Konrad on 6/25/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsAnchor
import FormsNetworkingImage
import UIKit

// MARK: AboutUsDisplayLogic
protocol AboutUsDisplayLogic: class {
    func displayContent(_ viewModel: AboutUs.GetContent.ViewModel)
}

// MARK: AboutUsViewController
class AboutUsViewController: FormsTableViewController, AboutUsDisplayLogic {
    var interactor: AboutUsBusinessLogic!
    var router: (AboutUsRoutingLogic & AboutUsDataPassing)!

    private let navigationBar = Components.navigationBar.logo.small()
    private let imageView = Components.image.default()
        .with(anchors: { [Anchor.to($0).heightToWidth.multiplier(0.5)] })
        .with(contentMode: .scaleAspectFill)
        .with(isPreviewable: true)
        .with(isStopAutoShimmer: false)
    private let descriptionLabel = Components.label.description()
        .with(marginTop: 16)
        .with(numberOfLines: 0)
    
    override func setupView() {
        super.setupView()
        self.getContent()
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()
        self.setNavigationBar(self.navigationBar)
    }

    override func setupContent() {
        super.setupContent()
        self.build([
            self.imageView,
            self.descriptionLabel
        ])
    }
}

// MARK: AboutUsDisplayLogic - GetContent
extension AboutUsViewController {
    private func getContent() {
        let request = AboutUs.GetContent.Request()
        self.interactor.getContent(request)
    }

    func displayContent(_ viewModel: AboutUs.GetContent.ViewModel) {
        let request = NetworkImageRequest(url: viewModel.image)
            .with(isAutoShimmer: true)
            .with(scaleToFill: self.imageView.frame.size)
        self.imageView.setImage(request: request)
        self.descriptionLabel.text = viewModel.description
    }
}
