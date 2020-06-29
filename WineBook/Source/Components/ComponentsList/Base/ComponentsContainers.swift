//
//  ComponentsContainers.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsUtils
import UIKit

extension ComponentsContainers {
    static func primaryGradient() -> GradientView {
        let component = Components.container.gradient()
        component.onSetTheme = Strong(component) { (component) in
            component.gradientColors = [Theme.Colors.secondary, Theme.Colors.primary]
        }
        return component
    }
}
