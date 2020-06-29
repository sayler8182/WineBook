//
//  DashboardViewController.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsTabBarKit
import UIKit

// MARK: DashboardDisplayLogic
protocol DashboardDisplayLogic: class {
    func displayContent(_ viewModel: Dashboard.GetContent.ViewModel)
}

// MARK: Keys
extension DashboardViewController {
    enum TabBarKeys: String, TabBarKey {
        enum Main: String, TabBarItemKey, CaseIterable {
            case home
            case discount
            case info
        }
        
        case main
        
        var keys: [TabBarItemKey] {
            switch self {
            case .main: return Main.allCases
            }
        }
    }
}

// MARK: DashboardViewController
class DashboardViewController: TabBarController, DashboardDisplayLogic {
    var interactor: DashboardBusinessLogic!
    var router: (DashboardRoutingLogic & DashboardDataPassing)!
    
    override func setTheme() {
        super.setTheme()
        self.tabBarImageSelectedColor = Theme.Colors.primary
        self.tabBarTitleSelectedColor = Theme.Colors.primary
    }
    
    override func setupView() {
        super.setupView()
        self.getContent()
    }
    
    override func setupSets() {
        super.setupSets()
        self.addSet([
            TabBarItem(
                itemKey: TabBarKeys.Main.home,
                viewController: { [unowned self] in
                    return self.router.homePath()
                },
                image: UIImage.from(name: "heart"),
                selectedImage: UIImage.from(name: "heart.fill"),
                title: "Home"
            ),
            TabBarItem(
                itemKey: TabBarKeys.Main.discount,
                viewController: { [unowned self] in
                    return self.router.discountPath()
                },
                image: UIImage.from(name: "heart"),
                selectedImage: UIImage.from(name: "heart.fill"),
                title: "Discount"
            ),
            TabBarItem(
                itemKey: TabBarKeys.Main.info,
                viewController: { [unowned self] in
                    return self.router.infoPath()
                },
                image: UIImage.from(name: "heart"),
                selectedImage: UIImage.from(name: "heart.fill"),
                title: "Info"
            )
        ], forKey: TabBarKeys.main)
    }
}

// MARK: DashboardDisplayLogic - GetContent
extension DashboardViewController {
    private func getContent() {
        let request = Dashboard.GetContent.Request()
        self.interactor.getContent(request)
    }

    func displayContent(_ viewModel: Dashboard.GetContent.ViewModel) {
        self.show(TabBarKeys.main, index: 0)
    }
}
