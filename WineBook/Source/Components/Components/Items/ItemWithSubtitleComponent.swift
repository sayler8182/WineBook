//
//  ItemWithSubtitleComponent.swift
//  WineBook
//
//  Created by Konrad on 6/26/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsAnchor
import UIKit

// MARK: ItemWithSubtitleComponent
class ItemWithSubtitleComponent: ClickableView {
    let gradientView = Components.container.primaryGradient()
        .with(clipsToBounds: true)
        .with(cornerRadius: 6)
    let titleLabel = Components.label.subtitle()
        .with(margin: 0)
    let subtitleLabel = Components.label.description()
        .with(margin: 0)
    let valueLabel = Components.label.title.medium()
        .with(margin: 0)
    let arrowView = Components.image.default()
        .with(contentMode: .scaleAspectFit)
        .with(image: UIImage.from(name: "chevron.right"))
    
    var colors: State<UIColor?> = State<UIColor?>(Theme.Colors.white) {
        didSet { self.updateState() }
    }
    var gradientColors: State<[UIColor?]> = State<[UIColor?]>([]) {
        didSet { self.updateState() }
    }
    var title: String? {
        get { return self.titleLabel.text }
        set { self.titleLabel.text = newValue }
    }
    var subtitle: String? {
        get { return self.subtitleLabel.text }
        set { self.subtitleLabel.text = newValue }
    }
    var value: String? {
        get { return self.valueLabel.text }
        set { self.valueLabel.text = newValue }
    }
    
    override func setupView() {
        super.setupView()
        self.setupTitleLabel()
        self.setupSubtitleLabel()
        self.setupValueLabel()
        self.setupArrowView()
        self.setupItemContent()
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        self.marginEdgeInset = UIEdgeInsets(
            vertical: 2,
            horizontal: 16)
    }
    
    override func setTheme() {
        self.colors = .init(Theme.Colors.white)
        self.gradientColors = .init(default: [Theme.Colors.secondary, Theme.Colors.primary])
    }
    
    func setupTitleLabel() {
        self.gradientView.addSubview(self.titleLabel, with: [
            Anchor.to(self.gradientView).top.offset(8),
            Anchor.to(self.gradientView).leading.offset(12)
        ])
    }
    
    func setupSubtitleLabel() {
        self.gradientView.addSubview(self.subtitleLabel, with: [
            Anchor.to(self.titleLabel).topToBottom.offset(2),
            Anchor.to(self.gradientView).bottom.offset(8),
            Anchor.to(self.gradientView).leading.offset(12)
        ])
    }
    
    func setupValueLabel() {
        self.gradientView.addSubview(self.valueLabel, with: [
            Anchor.to(self.gradientView).vertical.offset(8),
            Anchor.to(self.titleLabel).leadingToTrailing.offset(8),
            Anchor.to(self.titleLabel).leadingToTrailing.offset(8)
        ])
    }
    
    func setupArrowView() {
        self.gradientView.addSubview(self.arrowView, with: [
            Anchor.to(self.valueLabel).leadingToTrailing.offset(8),
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
        self.titleLabel.color = self.colors.value(for: state)
        self.subtitleLabel.color = self.colors.value(for: state)
        self.valueLabel.color = self.colors.value(for: state)
        self.arrowView.color = self.colors.value(for: state)
    }
}

// MARK: Builder
extension ItemWithSubtitleComponent {
    func with(title: String?) -> Self {
        self.title = title
        return self
    }
    func with(subtitle: String?) -> Self {
        self.subtitle = subtitle
        return self
    }
    func with(value: String?) -> Self {
        self.value = value
        return self
    }
}
