//
//  ComponentsLabels.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsUtils
import UIKit

extension ComponentsLabels {
    enum title {
        static func logo() -> Label {
            let component = ComponentsLabels.default()
            component.alignment = .center
            component.marginEdgeInset = UIEdgeInsets(horizontal: 16)
            component.viewKey = "ComponentsLabels.title.logo"
            component.onSetTheme = Strong(component) { (component) in
                component.backgroundColor = Theme.Colors.clear
                component.color = Theme.Colors.primaryDark
                component.font = Theme.Fonts.bold(ofSize: 32)
            }
            return component
        }
        static func auth() -> Label {
            let component = ComponentsLabels.title.big()
            component.marginEdgeInset = UIEdgeInsets(top: 44)
            return component
        }
        static func big() -> Label {
            let component = ComponentsLabels.default()
            component.marginEdgeInset = UIEdgeInsets(horizontal: 16)
            component.viewKey = "ComponentsLabels.title.big"
            component.onSetTheme = Strong(component) { (component) in
                component.backgroundColor = Theme.Colors.clear
                component.color = Theme.Colors.primaryDark
                component.font = Theme.Fonts.bold(ofSize: 32)
            }
            return component
        }
        static func medium() -> Label {
            let component = ComponentsLabels.default()
            component.numberOfLines = 2
            component.marginEdgeInset = UIEdgeInsets(top: 8, leading: 16, bottom: 4, trailing: 16)
            component.viewKey = "ComponentsLabels.title.medium"
            component.onSetTheme = Strong(component) { (component) in
                component.backgroundColor = Theme.Colors.clear
                component.color = Theme.Colors.primaryDark
                component.font = Theme.Fonts.bold(ofSize: 16)
            }
            return component
        }
    }
    static func description() -> Label {
        let component = Self.default()
        component.numberOfLines = 3
        component.marginEdgeInset = UIEdgeInsets(top: 4, leading: 16, bottom: 8, trailing: 16)
        component.viewKey = "ComponentsLabels.subtitle"
        component.onSetTheme = Strong(component) { (component) in
            component.backgroundColor = Theme.Colors.clear
            component.color = Theme.Colors.secondaryDark
            component.font = Theme.Fonts.regular(ofSize: 14)
        }
        return component
    }
    static func subtitle() -> Label {
        let component = Self.default()
        component.numberOfLines = 3
        component.marginEdgeInset = UIEdgeInsets(top: 2, leading: 16, bottom: 16, trailing: 16)
        component.viewKey = "ComponentsLabels.authSubtitle"
        component.onSetTheme = Strong(component) { (component) in
            component.backgroundColor = Theme.Colors.clear
            component.color = Theme.Colors.secondaryDark
            component.font = Theme.Fonts.regular(ofSize: 16)
        }
        return component
    }
}
