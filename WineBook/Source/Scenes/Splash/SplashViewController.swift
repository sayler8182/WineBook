//
//  SplashViewController.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsAnchor
import UIKit

// MARK: SplashDisplayLogic
protocol SplashDisplayLogic: class {
    func displayContent(_ viewModel: Splash.GetContent.ViewModel)
}

// MARK: SplashViewController
class SplashViewController: FormsViewController {
    var interactor: SplashBusinessLogic!
    var router: (SplashRoutingLogic & SplashDataPassing)!

    private var logo = Components.logo.big()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return ThemeBarStyle.light.style
    }
    
    override func setupView() {
        super.setupView()
        self.getContent()
    }
    
    override func setTheme() {
        super.setTheme()
        self.view.backgroundColor = Theme.Colors.black
        self.logo.backgroundColor = Theme.Colors.black
    }
    
    override func setupContent() {
        super.setupContent()
        self.view.addSubview(self.logo, with: [
            Anchor.to(self.view).horizontal.offset(16),
            Anchor.to(self.view).centerY
        ])
    }
}

// MARK: SplashDisplayLogic - GetContent
extension SplashViewController: SplashDisplayLogic {
    private func getContent() {
        let request = Splash.GetContent.Request()
        self.interactor.getContent(request)
    }

    func displayContent(_ viewModel: Splash.GetContent.ViewModel) {
        if viewModel.isSessionActive {
            self.router.routeToDashboard()
        } else {
            self.router.routeToLogin()
        }
    }
}
