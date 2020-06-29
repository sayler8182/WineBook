//
//  PurchaseTableViewCell.swift
//  WineBook
//
//  Created by Konrad on 6/26/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsAnchor
import FormsNetworking
import FormsUtils
import UIKit

// MARK: PurchaseCellModelProtocol
protocol PurchaseCellModelProtocol {
    var date: String? { get }
    var items: String? { get }
    var amount: String? { get }
}

// MARK: PurchaseTableViewCell
class PurchaseTableViewCell: FormsTableViewCell {
    let gradientView = Components.container.primaryGradient()
        .with(clipsToBounds: true)
        .with(cornerRadius: 6)
    let dateLabel = Components.label.subtitle()
        .with(margin: 0)
        .with(isShimmerable: false)
    let itemsLabel = Components.label.description()
        .with(margin: 0)
        .with(isShimmerable: false)
    let amountLabel = Components.label.title.medium()
        .with(margin: 0)
        .with(isShimmerable: false)
    let arrowView = Components.image.default()
        .with(contentMode: .scaleAspectFit)
        .with(image: UIImage.from(name: "chevron.right"))
        .with(isShimmerable: false)
    
    override func setupView() {
        super.setupView()
        self.gradientView.addSubview(self.dateLabel, with: [
            Anchor.to(self.gradientView).top.offset(8),
            Anchor.to(self.gradientView).leading.offset(12)
        ])
        self.gradientView.addSubview(self.itemsLabel, with: [
            Anchor.to(self.dateLabel).topToBottom.offset(2),
            Anchor.to(self.gradientView).bottom.offset(8),
            Anchor.to(self.gradientView).leading.offset(12)
        ])
        self.gradientView.addSubview(self.amountLabel, with: [
            Anchor.to(self.gradientView).vertical.offset(8),
            Anchor.to(self.dateLabel).leadingToTrailing.greaterThanOrEqual.offset(8),
            Anchor.to(self.itemsLabel).leadingToTrailing.greaterThanOrEqual.offset(8)
        ])
        self.gradientView.addSubview(self.arrowView, with: [
            Anchor.to(self.amountLabel).leadingToTrailing.offset(8),
            Anchor.to(self.gradientView).trailing.offset(8),
            Anchor.to(self.gradientView).centerY,
            Anchor.to(self.arrowView).widthToHeight
        ])
        self.contentView.addSubview(self.gradientView, with: [
            Anchor.to(self.contentView).vertical.offset(2),
            Anchor.to(self.contentView).horizontal.offset(16)
        ])
    }
    
    override func setTheme() {
        super.setTheme()
        self.backgroundColor = Theme.Colors.primaryLight
        self.dateLabel.color = Theme.Colors.white
        self.itemsLabel.color = Theme.Colors.white
        self.amountLabel.color = Theme.Colors.white
        self.arrowView.color = Theme.Colors.white
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.dateLabel.text = nil
        self.itemsLabel.text = nil
        self.amountLabel.text = nil
    }
     
    func fill(_ source: PurchaseCellModelProtocol) {
        self.dateLabel.text = source.date
        self.itemsLabel.text = source.items
        self.amountLabel.text = source.amount
    }
}

// MARK: ShimmerPurchaseTableViewCell
class ShimmerPurchaseTableViewCell: PurchaseTableViewCell {
    override func prepareForShimmering() {
        self.dateLabel.text = LoremIpsum.emptyShort
        self.itemsLabel.text = LoremIpsum.emptyShort
        self.amountLabel.text = LoremIpsum.emptyShort
    }
}
