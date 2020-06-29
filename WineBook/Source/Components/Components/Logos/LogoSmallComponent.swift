//
//  LogoSmallComponent.swift
//  WineBook
//
//  Created by Konrad on 6/25/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsAnchor
import FormsUtils
import UIKit

// MARK: LogoSmallComponent
func LogoSmallComponent() -> FormsComponent {
    let component = Components.label.title.logo()
        .with(text: "Wine Book")
    component.onSetTheme = Strong(component) { (component) in
        component.backgroundColor = Theme.Colors.clear
        component.color = Theme.Colors.primaryDark
        component.font = Theme.Fonts.bold(ofSize: 18)
    }
    return component
}
