//
//  ProductDetailsViewController.swift
//  WineBook
//
//  Created by Konrad on 6/23/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsAnchor
import FormsNetworkingImage
import FormsToastKit
import FormsUtils
import UIKit

// MARK: ProductDetailsDisplayLogic
protocol ProductDetailsDisplayLogic: class {
    func displayContent(_ viewModel: ProductDetails.GetContent.ViewModel)
    func displayContent(_ error: ProductDetails.Error)
}

// MARK: ProductDetailsViewController
class ProductDetailsViewController: FormsTableViewController, ProductDetailsDisplayLogic {
    var interactor: ProductDetailsBusinessLogic!
    var router: (ProductDetailsRoutingLogic & ProductDetailsDataPassing)!
    
    private let navigationBar = Components.navigationBar.logo.small()
    private let imageView = Components.image.default()
        .with(anchors: { [Anchor.to($0).heightToWidth.multiplier(0.5)] })
        .with(contentMode: .scaleAspectFill)
        .with(isPreviewable: true)
        .with(isStopAutoShimmer: false)
    private let titleLabel = Components.label.title.medium()
        .with(text: " ")
    private let separator = Components.utils.divider.gradient()
    private let descriptionLabel = Components.label.description()
        .with(numberOfLines: 0)
        .with(text: "\n\n")
    
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
            self.titleLabel,
            self.separator,
            self.descriptionLabel
        ])
    }
}

// MARK: ProductDetailsDisplayLogic - GetContent
extension ProductDetailsViewController {
    private func getContent() {
        self.startShimmering()
        let request = ProductDetails.GetContent.Request()
        self.interactor.getContent(request)
    }

    func displayContent(_ viewModel: ProductDetails.GetContent.ViewModel) {
        self.stopShimmering()
        let request = NetworkImageRequest(url: viewModel.image)
            .with(isStopAutoShimmer: true)
            .with(scaleToFill: self.imageView.frame.size)
        self.imageView.setImage(request: request)
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
    }
    
    func displayContent(_ error: ProductDetails.Error) {
        self.stopShimmering()
        Toast.error()
            .with(title: error.reason)
            .show(in: self.navigationController)
    }
}
