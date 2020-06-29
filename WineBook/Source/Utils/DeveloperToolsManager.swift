//
//  DeveloperToolsManager.swift
//  FormsDemo
//
//  Created by Konrad on 6/13/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsDeveloperTools
import UIKit

// MARK: DeveloperToolsManager
enum DeveloperToolsManager {
    static func onSelect(_ key: DeveloperFeatureKeyProtocol,
                         _ rootController: UIViewController) {
        guard let controller = Self.controller(for: key) else { return }
        rootController.show(controller, sender: nil)
    }
    
    private static func controller(for key: DeveloperFeatureKeyProtocol) -> UIViewController? {
        return nil
    }
}

// MARK: DeveloperFeatureKeys
enum DeveloperFeatureKeys: String, CaseIterable, DeveloperFeatureKeyProtocol {
    case unknown
    
    var title: String {
        return ""
    }
}

// MARK: DeveloperFeatureFlagKeys
enum DeveloperFeatureFlagKeys: String, CaseIterable, DeveloperFeatureFlagKeyProtocol {
    case unknown
    
    var title: String {
        return ""
    }
}
