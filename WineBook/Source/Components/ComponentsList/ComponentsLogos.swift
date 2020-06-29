//
//  ComponentsLogos.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsUtils
import UIKit

enum ComponentsLogos: ComponentsList {
    static func big() -> FormsComponent {
        let component = LogoBigComponent()
        return component
    }
    
    static func small() -> FormsComponent {
        let component = LogoSmallComponent()
        return component
    }
}
