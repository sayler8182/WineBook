//
//  ProductTableViewCell.swift
//  WineBook
//
//  Created by Konrad on 6/22/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsAnchor
import FormsNetworkingImage
import FormsUtils
import UIKit

// MARK: ProductCellModelProtocol
protocol ProductCellModelProtocol {
    var image: URL? { get }
    var title: String? { get }
    var description: String? { get }
}

// MARK: ProductTableViewCell
class ProductTableViewCell: FormsTableViewCell {
    let mainImageView = Components.image.default()
        .with(contentMode: .scaleAspectFill)
    let titleLabel = Components.label.title.medium()
    let descriptionLabel = Components.label.description()
    let separator = Components.utils.divider.gradient()
    
    override func setupView() {
        super.setupView()
        self.contentView.addSubview(self.mainImageView, with: [
            Anchor.to(self.contentView).top,
            Anchor.to(self.contentView).horizontal,
            Anchor.to(self.mainImageView).heightToWidth.multiplier(0.5)
        ])
        self.contentView.addSubview(self.titleLabel, with: [
            Anchor.to(self.mainImageView).topToBottom,
            Anchor.to(self.contentView).leading,
            Anchor.to(self.contentView).trailing.greaterThanOrEqual
        ])
        self.contentView.addSubview(self.descriptionLabel, with: [
            Anchor.to(self.titleLabel).topToBottom,
            Anchor.to(self.contentView).leading,
            Anchor.to(self.contentView).trailing.greaterThanOrEqual
        ])
        self.contentView.addSubview(self.separator, with: [
            Anchor.to(self.descriptionLabel).topToBottom,
            Anchor.to(self.contentView).horizontal,
            Anchor.to(self.contentView).bottom.offset(8),
            Anchor.to(self.separator).height(2.0)
        ])
    }
    
    override func setTheme() {
        super.setTheme()
        self.backgroundColor = Theme.Colors.primaryLight
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.mainImageView.cancel()
        self.mainImageView.image = nil
        self.titleLabel.text = nil
        self.descriptionLabel.text = nil
    } 
     
    func fill(_ source: ProductCellModelProtocol) {
        let request = NetworkImageRequest(
            url: source.image)
            .with(isAutoShimmer: true)
            .with(scaleToFill: self.mainImageView.frame.size)
        self.mainImageView.setImage(request: request)
        self.titleLabel.text = source.title
        self.descriptionLabel.text = source.description
    }
}

// MARK: ShimmerProductTableViewCell
class ShimmerProductTableViewCell: ProductTableViewCell {
    override func prepareForShimmering() {
        self.mainImageView.image = nil
        self.titleLabel.text = LoremIpsum.emptyShort
        self.descriptionLabel.text = LoremIpsum.emptyLong
    }
}
