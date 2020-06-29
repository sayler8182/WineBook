//
//  PurchasesViewController.swift
//  WineBook
//
//  Created by Konrad on 6/26/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsAnchor
import FormsToastKit
import UIKit

// MARK: PurchasesDisplayLogic
protocol PurchasesDisplayLogic: class {
    func displayContent(_ viewModel: Purchases.GetContent.ViewModel)
    func displayContent(_ error: Purchases.Error)
}

// MARK: PurchasesViewController
class PurchasesViewController: FormsViewController, PurchasesDisplayLogic {
    var interactor: PurchasesBusinessLogic!
    var router: (PurchasesRoutingLogic & PurchasesDataPassing)!

    private let navigationBar = Components.navigationBar.main()
    private let titleLabel = Components.label.title.big()
        .with(text: "Purchases")
    private let subtitleLabel = Components.label.subtitle()
        .with(text: "There are your purchases whichypu bought in Wine Book")
    private let tableView = UITableView()
        .with(alwaysBounceVertical: false)
        .with(contentInset: UIEdgeInsets(bottom: UIView.safeArea.bottom))
        .with(separatorStyle: UITableViewCell.SeparatorStyle.none)
    
    private lazy var dataSource: ShimmerTableDataSource = ShimmerTableDataSource()
        .with(generators: [
            ShimmerRowGenerator(type: ShimmerPurchaseTableViewCell.self, count: 6)
        ])
        .with(delegate: self)
    
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
        self.view.addSubview(self.titleLabel, with: [
            Anchor.to(self.view).top.safeArea,
            Anchor.to(self.view).horizontal
        ])
        self.view.addSubview(self.subtitleLabel, with: [
            Anchor.to(self.titleLabel).topToBottom,
            Anchor.to(self.view).horizontal
        ])
        self.view.addSubview(self.tableView, with: [
            Anchor.to(self.subtitleLabel).topToBottom.offset(16),
            Anchor.to(self.view).horizontal,
            Anchor.to(self.view).bottom
        ])
        self.setupTableView()
    }
    
    override func setTheme() {
        super.setTheme()
        self.tableView.backgroundColor = Theme.Colors.primaryLight
    }
    
    func setupTableView() {
        self.tableView.delegate = self.dataSource
        self.tableView.dataSource = self.dataSource
        self.dataSource.prepare(for: self.tableView)
        self.dataSource.prepareGenerators()
    }
}

// MARK: PurchasesDisplayLogic - GetContent
extension PurchasesViewController {
    private func getContent() {
        let request = Purchases.GetContent.Request()
        self.interactor.getContent(request)
    }

    func displayContent(_ viewModel: Purchases.GetContent.ViewModel) {
        let items = [
            TableSection(
                of: PurchasesSection.self,
                data: viewModel.totalAmount,
                rows: viewModel.purchases.map { purchase in
                    TableRow(of: PurchaseTableViewCell.self, data: purchase)
            })
        ]
        self.dataSource.stopShimmering(animated: true)
        self.dataSource.setItems(items)
    }
    
    func displayContent(_ error: Purchases.Error) {
        Toast.error()
            .with(title: error.reason)
            .show(in: self.navigationController)
    }
}

// MARK: PurchasesViewController
extension PurchasesViewController: TableDataSourceDelegateProtocol {
    func setupSection(section: TableSection, view: FormsComponent, index: Int) {
        view.cast(section: section, of: String.self, to: SectionView.self) { (newData, newView) in
            newView.text = newData
        }
    }
    
    func setupCell(row: TableRow, cell: FormsTableViewCell, indexPath: IndexPath) {
        cell.cast(row: row, of: Purchases.PurchaseCellModel.self, to: PurchaseTableViewCell.self) { (newData, newCell) in
            newCell.fill(newData)
        }
    }
    
    func selectCell(row: TableRow, cell: FormsTableViewCell, indexPath: IndexPath) { }
}
