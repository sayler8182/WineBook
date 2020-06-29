//
//  InfoViewController.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import UIKit

// MARK: InfoDisplayLogic
protocol InfoDisplayLogic: class {
    func displayContent(_ viewModel: Info.GetContent.ViewModel)
}

// MARK: InfoViewController
class InfoViewController: FormsTableViewController, InfoDisplayLogic {
    var interactor: InfoBusinessLogic!
    var router: (InfoRoutingLogic & InfoDataPassing)!

    private let navigationBar = Components.navigationBar.logo.small()
    private let profileView = Components.item.withIcon()
        .with(icon: UIImage.from(name: "person"))
        .with(title: "Profile")
    private let purchasesView = Components.item.withIcon()
        .with(icon: UIImage.from(name: "person"))
        .with(title: "Purchases")
    // private let discountView = Components.item.withIcon()
    //    .with(icon: UIImage.from(name: "person"))
    //    .with(title: "Discount")
    private let aboutUsView = Components.item.withIcon()
        .with(icon: UIImage.from(name: "person"))
        .with(title: "About us")
    private let contactView = Components.item.withIcon()
        .with(icon: UIImage.from(name: "person"))
        .with(title: "Contact")
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        self.setNavigationBar(self.navigationBar)
    }
    
    override func setupView() {
        super.setupView()
        self.getContent()
    }

    override func setupContent() {
        super.setupContent()
        self.build([
            self.profileView,
            self.purchasesView,
            // self.discountView,
            self.aboutUsView,
            self.contactView
        ])
    }
    
    override func setupActions() {
        self.profileView.onClick = { [unowned self] in
            self.router.routeToProfile()
        }
        self.purchasesView.onClick = { [unowned self] in
            self.router.routeToPurchases()
        }
        // self.discountView.onClick = { [unowned self] in }
        self.aboutUsView.onClick = { [unowned self] in
            self.router.routeToAboutUs()
        }
        self.contactView.onClick = { [unowned self] in
            self.router.routeToContact()
        }
    }
}

// MARK: InfoDisplayLogic - GetContent
extension InfoViewController {
    private func getContent() {
        let request = Info.GetContent.Request()
        self.interactor.getContent(request)
    }

    func displayContent(_ viewModel: Info.GetContent.ViewModel) { }
}
