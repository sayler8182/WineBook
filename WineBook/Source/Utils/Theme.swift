//
//  Theme.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsInjector
import UIKit

// MARK: ThemeColorsKey
public extension ThemeColorsKey {
    static var primary = ThemeColorsKey("primary")
    static var secondary = ThemeColorsKey("secondary")
}

// MARK: ThemeColorsProtocol
public extension ThemeColorsProtocol {
    var primary: UIColor {
        return self.color(.primary)
    }
    
    var secondary: UIColor {
        return self.color(.secondary)
    }
} 
