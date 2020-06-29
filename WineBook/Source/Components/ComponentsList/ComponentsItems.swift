//
//  ComponentsItems.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsUtils
import UIKit

enum ComponentsItems: ComponentsList {
    static func withIcon() -> ItemWithIconComponent {
        let component = ItemWithIconComponent()
        return component
    }
    static func withSubtitle() -> ItemWithSubtitleComponent {
        let component = ItemWithSubtitleComponent()
        return component
    }
}
