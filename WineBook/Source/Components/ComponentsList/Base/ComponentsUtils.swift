//
//  ComponentsUtils.swift
//  WineBook
//
//  Created by Konrad on 6/23/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsUtils
import UIKit

extension ComponentsUtils {
    enum divider {
        static func gradient(height: CGFloat = 1) -> GradientDivider {
            let component = Components.utils.gradientDivider()
            component.marginEdgeInset = UIEdgeInsets(horizontal: 8)
            component.height = 2
            component.isShimmerable = true
            component.onSetTheme = Strong(component) { (component) in
                component.colors = [Theme.Colors.secondary, Theme.Colors.primary]
            }
            return component
        }
    }
}
