//
//  ComponentsNavigationBars.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsUtils
import UIKit

extension ComponentsNavigationBars {
    static func main() -> NavigationBar {
        let component = NavigationBar()
        component.backImage = { UIImage.from(name: "chevron.left") }
        component.closeImage = { UIImage.from(name: "xmark") }
        component.isShadow = false
        component.onSetTheme = Strong(component) { (component) in
            component.backgroundColor = Theme.Colors.primaryLight
            component.tintColor = Theme.Colors.primaryDark
        }
        return component
    }
    enum logo {
        static func small() -> NavigationBar {
            let logo = Components.logo.small()
            let component = Components.navigationBar.main()
                .with(titleView: logo)
            return component
        }
    }
}
