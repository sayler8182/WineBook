//
//  PurchasesSection.swift
//  WineBook
//
//  Created by Konrad on 6/29/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsAnchor
import UIKit

// MARK: PurchasesSection
class PurchasesSection: SectionView {
    override func setTheme() {
        super.setTheme()
        self.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        self.alignment = .notNatural
        self.marginEdgeInset = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 52)
    }
}
