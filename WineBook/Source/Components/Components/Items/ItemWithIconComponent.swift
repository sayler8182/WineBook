//
//  ItemWithIconComponent.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsAnchor
import UIKit

// MARK: ItemWithIconComponent
class ItemWithIconComponent: ClickableView {
    let gradientView = Components.container.primaryGradient()
        .with(clipsToBounds: true)
    let iconView = Components.image.default()
        .with(contentMode: .scaleAspectFit)
    let titleLabel = Components.label.title.medium()
        .with(margin: 0)
        .with(numberOfLines: 2)
    let arrowView = Components.image.default()
        .with(contentMode: .scaleAspectFit)
        .with(image: UIImage.from(name: "chevron.right"))
    
    var colors: State<UIColor?> = State<UIColor?>(Theme.Colors.white) {
        didSet { self.updateState() }
    }
    var gradientColors: State<[UIColor?]> = State<[UIColor?]>([]) {
        didSet { self.updateState() }
    }
    var icon: UIImage? {
        get { return self.iconView.image }
        set { self.iconView.image = newValue }
    }
    var title: String? {
        get { return self.titleLabel.text }
        set { self.titleLabel.text = newValue }
    }
    
    override func setupView() {
        super.setupView()
        self.setupIconView()
        self.setupTitleLabel()
        self.setupArrowView()
        self.setupItemContent()
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        self.gradientView.layer.cornerRadius = 6.0
        self.marginEdgeInset = UIEdgeInsets(
            vertical: 2,
            horizontal: 16)
    }
    
    override func setTheme() {
        self.colors = .init(Theme.Colors.white)
        self.gradientColors = .init(default: [Theme.Colors.secondary, Theme.Colors.primary])
    }
    
    func setupIconView() {
        self.gradientView.addSubview(self.iconView, with: [
            Anchor.to(self.gradientView).vertical.offset(12),
            Anchor.to(self.gradientView).leading.offset(12),
            Anchor.to(self.iconView).widthToHeight
        ])
    }
    
    func setupTitleLabel() {
        self.gradientView.addSubview(self.titleLabel, with: [
            Anchor.to(self.iconView).leadingToTrailing.offset(8),
            Anchor.to(self.gradientView).vertical.offset(8)
        ])
    }
    
    func setupArrowView() {
        self.gradientView.addSubview(self.arrowView, with: [
            Anchor.to(self.titleLabel).leadingToTrailing.offset(8),
            Anchor.to(self.gradientView).trailing.offset(8),
            Anchor.to(self.gradientView).centerY,
            Anchor.to(self.arrowView).widthToHeight
        ])
    }
    
    func setupItemContent() {
        self.content = self.gradientView
    }
    
    override func setStateAnimation(_ state: FormsComponentStateType) {
        self.gradientView.gradientColors = self.gradientColors.value(for: state)
        self.iconView.color = self.colors.value(for: state)
        self.titleLabel.color = self.colors.value(for: state)
        self.arrowView.color = self.colors.value(for: state)
    }
}

// MARK: Builder
extension ItemWithIconComponent {
    func with(icon: UIImage?) -> Self {
        self.icon = icon
        return self
    }
    func with(title: String?) -> Self {
        self.title = title
        return self
    }
}
