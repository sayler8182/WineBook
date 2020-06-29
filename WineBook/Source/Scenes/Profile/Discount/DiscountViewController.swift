//
//  DiscountViewController.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsAnchor
import FormsToastKit
import FormsUtils
import UIKit

// MARK: DiscountDisplayLogic
protocol DiscountDisplayLogic: class {
    func displayContent(_ viewModel: Discount.GetContent.ViewModel)
    func displayContent(_ error: Discount.Error)
}

// MARK: DiscountViewController
class DiscountViewController: FormsViewController, DiscountDisplayLogic {
    var interactor: DiscountBusinessLogic!
    var router: (DiscountRoutingLogic & DiscountDataPassing)!

    private let navigationBar = Components.navigationBar.logo.small()
    private let codeView = Components.image.default()
        .with(contentMode: .scaleAspectFit)
        .with(isPreviewable: true)

    override func setupNavigationBar() {
        super.setupNavigationBar()
        self.setNavigationBar(self.navigationBar)
    }

    override func setupContent() {
        super.setupContent()
        self.view.addSubview(self.codeView, with: [
            Anchor.to(self.view).vertical.offset(16),
            Anchor.to(self.view).horizontal.offset(32)
        ])
    }
    
    override func setTheme() {
        super.setTheme()
        self.getContent()
    }
}

// MARK: DiscountDisplayLogic - GetContent
extension DiscountViewController {
    private func getContent() {
        self.codeView.startShimmering()
        let request = Discount.GetContent.Request()
        self.interactor.getContent(request)
    }

    func displayContent(_ viewModel: Discount.GetContent.ViewModel) {
        let request = CodeGeneratorRequest()
            .with(background: Theme.Colors.primaryLight)
            .with(foreground: Theme.Colors.primaryDark)
            .with(size: CGSize(
                width: self.codeView.frame.size.height,
                height: self.codeView.frame.size.width))
        let image: UIImage? = viewModel.code
            .code(type: .code128Barcode, request: request)?
            .rotated(degress: 90)
        self.codeView.image = image
        self.codeView.stopShimmering()
    }
    
    func displayContent(_ error: Discount.Error) {
        Toast.error()
            .with(title: error.reason)
            .show(in: self.navigationController)
    }
}
