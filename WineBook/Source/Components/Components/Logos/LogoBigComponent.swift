//
//  LogoBigComponent.swift
//  WineBook
//
//  Created by Konrad on 6/25/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsAnchor
import UIKit

// MARK: LogoBigComponent
func LogoBigComponent() -> FormsComponent {
    let logoImage = Components.image.default()
        .with(image: UIImage.from(name: ""))
    let logoTitleLabel = Components.label.title.logo()
        .with(text: "Wine Book")
    let component = Components.container.stack()
        .with(axis: .vertical)
        .with(distribution: .equalSpacing)
        .with(items: [logoImage, logoTitleLabel])
    return component
}
