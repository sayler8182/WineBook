//
//  ContactComponent.swift
//  WineBook
//
//  Created by Konrad on 6/25/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsAnchor
import UIKit

// MARK: ItemWithIconComponent
class ContactComponent: ClickableView {
    let wrapperView = Components.container.view()
        .with(clipsToBounds: true)
    let iconView = Components.image.default()
        .with(contentMode: .scaleAspectFit)
    let titleLabel = Components.label.description()
        .with(margin: 0)
        .with(numberOfLines: 2)
    
    var colors: State<UIColor?> = State<UIColor?>(Theme.Colors.primaryDark) {
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
        self.setupItemContent()
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        self.marginEdgeInset = UIEdgeInsets(
            vertical: 2,
            horizontal: 16)
    }
    
    override func setTheme() {
        super.setTheme()
        self.colors = .init(default: Theme.Colors.primaryDark)
    }
    
    func setupIconView() {
        self.wrapperView.addSubview(self.iconView, with: [
            Anchor.to(self.wrapperView).vertical,
            Anchor.to(self.wrapperView).leading,
            Anchor.to(self.iconView).widthToHeight
        ])
    }
    
    func setupTitleLabel() {
        self.wrapperView.addSubview(self.titleLabel, with: [
            Anchor.to(self.iconView).leadingToTrailing.offset(8),
            Anchor.to(self.wrapperView).vertical.offset(4),
            Anchor.to(self.wrapperView).trailing
        ])
    }
    
    func setupItemContent() {
        self.content = self.wrapperView
    }
    
    override func setStateAnimation(_ state: FormsComponentStateType) {
        self.iconView.color = self.colors.value(for: state)
        self.titleLabel.color = self.colors.value(for: state)
    }
}

// MARK: Builder
extension ContactComponent {
    func with(icon: UIImage?) -> Self {
        self.icon = icon
        return self
    }
    func with(title: String?) -> Self {
        self.title = title
        return self
    }
}
