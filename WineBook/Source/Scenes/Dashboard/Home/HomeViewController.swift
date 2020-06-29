//
//  HomeViewController.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsToastKit
import UIKit

// MARK: HomeDisplayLogic
protocol HomeDisplayLogic: class {
    func displayContent(_ viewModel: Home.GetContent.ViewModel)
    func displayContent(_ error: Home.Error)
    func displayResetContent(_ viewModel: Home.ResetContent.ViewModel)
    func displayDetails(_ viewModel: Home.Details.ViewModel)
}

// MARK: HomeViewController
class HomeViewController: FormsTableViewController, HomeDisplayLogic {
    var interactor: HomeBusinessLogic!
    var router: (HomeRoutingLogic & HomeDataPassing)!

    private let navigationBar = Components.navigationBar.logo.small()
    
    private lazy var shimmerDataSource = ShimmerTableDataSource()
        .with(generators: [ShimmerRowGenerator(type: ShimmerProductTableViewCell.self, count: 2)])
        .with(delegate: self)
    
    override func setupConfiguration() {
        super.setupConfiguration()
        self.paginationIsEnabled = true
        self.paginationOffset = 300
        self.pullToRefreshIsEnabled = true
        self.tableAllowsSelection = true
        self.tableContentInset = UIEdgeInsets(bottom: 300)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        self.setNavigationBar(self.navigationBar)
    }
    
    override func setupCell(row: TableRow, cell: FormsTableViewCell, indexPath: IndexPath) {
        super.setupCell(row: row, cell: cell, indexPath: indexPath)
        cell.cast(row: row, of: Home.ProductCellModel.self, to: ProductTableViewCell.self) { (newData, newCell) in
            newCell.fill(newData)
        }
    }
    
    override func selectCell(row: TableRow, cell: FormsTableViewCell, indexPath: IndexPath) {
        super.selectCell(row: row, cell: cell, indexPath: indexPath)
        cell.cast(row: row, of: Home.ProductCellModel.self, to: ProductTableViewCell.self) { [unowned self] (newData, _) in
            self.details(productId: newData.id)
        }
    }
    
    override func paginationNext() {
        self.startShimmering(self.shimmerDataSource)
        self.getContent()
    }
    
    override func pullToRefresh() {
        super.pullToRefresh()
        self.shimmerDataSource.reset()
        self.resetContent()
    }
}

// MARK: HomeDisplayLogic - GetContent
extension HomeViewController {
    private func getContent() {
        let request = Home.GetContent.Request()
        self.interactor.getContent(request)
    }

    func displayContent(_ viewModel: Home.GetContent.ViewModel) {
        self.stopShimmering()
        let rows: [TableRow] = viewModel.products.map { TableRow(of: ProductTableViewCell.self, data: $0) }
        self.shimmerDataSource.append(rows)
        self.paginationSuccess(delay: 0.5, isLast: viewModel.isLast)
        self.pullToRefreshFinish()
    }
    
    func displayContent(_ error: Home.Error) {
        self.stopShimmering()
        Toast.error()
            .with(title: error.reason)
            .show(in: self.navigationController)
        self.paginationError(delay: 3.0, isLast: false)
        self.pullToRefreshFinish()
    }
}

// MARK: HomeDisplayLogic - ResetContent
extension HomeViewController {
    private func resetContent() {
        let request = Home.ResetContent.Request()
        self.interactor.resetContent(request)
    }

    func displayResetContent(_ viewModel: Home.ResetContent.ViewModel) {
        self.paginationNext()
    }
}

// MARK: HomeDisplayLogic - Details
extension HomeViewController {
    private func details(productId: String) {
        let request = Home.Details.Request(
            productId: productId)
        self.interactor.details(request)
    }

    func displayDetails(_ viewModel: Home.Details.ViewModel) {
        self.router.routeToProductDetails()
    }
}
