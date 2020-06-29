//
//  ComponentsButtons.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsUtils
import UIKit

extension ComponentsButtons {
    static func primary() -> Button {
        let component = GradientButton()
        component.cornerRadius = 6.0
        component.paddingEdgeInset = UIEdgeInsets(8)
        component.marginEdgeInset = UIEdgeInsets(
            vertical: 8,
            horizontal: 16)
        component.titleTextAlignment = .center
        component.viewKey = "ComponentsButtons.primary"
        component.onSetTheme = Strong(component) { (component) in
            component.gradientColors = .init(default: [Theme.Colors.secondary, Theme.Colors.primary])
            component.titleColors = .init(Theme.Colors.white)
            component.titleFonts = .init(Theme.Fonts.bold(ofSize: 16))
        }
        return component
    }
    
    static func secondary() -> Button {
        let component = Button()
        component.borderWidth = 2
        component.cornerRadius = 6.0
        component.paddingEdgeInset = UIEdgeInsets(8)
        component.marginEdgeInset = UIEdgeInsets(
            vertical: 8,
            horizontal: 16)
        component.titleTextAlignment = .center
        component.viewKey = "ComponentsButtons.secondary"
        component.onSetTheme = Strong(component) { (component) in
            component.backgroundColors = .init(Theme.Colors.primaryLight)
            component.borderColors = .init(default: Theme.Colors.primaryDark)
            component.titleColors = .init(Theme.Colors.primaryDark)
            component.titleFonts = .init(Theme.Fonts.bold(ofSize: 16))
        }
        return component
    }
}
