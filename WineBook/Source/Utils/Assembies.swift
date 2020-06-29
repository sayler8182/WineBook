//
//  Assembies.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsHomeShortcuts
import FormsInjector
import FormsLogger
import UIKit

// MARK: ScenesAssembly
struct ScenesAssembly: Assembly {
    private var assemblies: AssemblyGroup = AssemblyGroup("Scenes", [
        AssemblyGroup("Auth", [
            LoginAssembly(),
            LoginWithEmailAssembly(),
            LoginWithEmailCodeAssembly(),
            LoginWithEmailPasswordAssembly(),
            RegisterWithEmailAssembly()
        ]),
        AssemblyGroup("Home", [
            AboutUsAssembly(),
            ContactAssembly(),
            DashboardAssembly(),
            HomeAssembly(),
            InfoAssembly()
        ]),
        AssemblyGroup("Profile", [
            DiscountAssembly(),
            ProfileAssembly()
        ]),
        AssemblyGroup("Products", [
            ProductDetailsAssembly()
        ]),
        AssemblyGroup("Purchases", [
            PurchasesAssembly()
        ]),
        AssemblyGroup("Other", [
            SplashAssembly()
        ])
    ])
    
    init() { }
    
    func assemble(injector: Injector) {
        self.assemblies.assemble(injector: injector)
    }
}

// MARK: ThemeAssembly
class ThemeAssembly: Assembly {
    func assemble(injector: Injector) {
        injector.register(ThemeColorsProtocol.self, name: ThemeType.light.key) { _ in
            ThemeColors(colors: [
                // base colors
                .black: UIColor(rgba: 0x181717FF),
                .blue: UIColor(rgba: 0x007AFFFF),
                .gray: UIColor(rgba: 0x8E8E93FF),
                .green: UIColor(rgba: 0x34C759FF),
                .orange: UIColor(rgba: 0xFFA500FF),
                .red: UIColor(rgba: 0xFF3B30FF),
                .white: UIColor(rgba: 0xFFFFFFFF),
                .primaryDark: UIColor(rgba: 0x181717FF),
                .secondaryDark: UIColor(rgba: 0x3C3C4399),
                .tertiaryDark: UIColor(rgba: 0x3C3C434D),
                .primaryLight: UIColor(rgba: 0xFFFFFFFF),
                .secondaryLight: UIColor(rgba: 0xF2F2F7FF),
                .tertiaryLight: UIColor(rgba: 0xFFFFFFFF),
                // app colors
                .primary: UIColor(0xAF3636),
                .secondary: UIColor(0xCF6161)
            ], statusBar: .dark)
        }
        .inScope(InjectorScope.container)
        injector.register(ThemeColorsProtocol.self, name: ThemeType.dark.key) { _ in
            ThemeColors(colors: [
                // base colors
                .black: UIColor(rgba: 0x181717FF),
                .blue: UIColor(rgba: 0x0A84FFFF),
                .gray: UIColor(rgba: 0x8E8E93FF),
                .green: UIColor(rgba: 0x30D158FF),
                .orange: UIColor(rgba: 0xFFA500FF),
                .red: UIColor(rgba: 0xFF375FFF),
                .white: UIColor(rgba: 0xFFFFFFFF),
                .primaryDark: UIColor(rgba: 0xFFFFFFFF),
                .secondaryDark: UIColor(rgba: 0xEBEBF599),
                .tertiaryDark: UIColor(rgba: 0xEBEBF54D),
                .primaryLight: UIColor(rgba: 0x181717FF),
                .secondaryLight: UIColor(rgba: 0x1C1C1EFF),
                .tertiaryLight: UIColor(rgba: 0x2C2C2EFF),
                // app colors
                .primary: UIColor(0xAF3636),
                .secondary: UIColor(0xCF6161)
            ], statusBar: .light)
        }
        .inScope(InjectorScope.container)
        injector.register(ThemeFontsProtocol.self) { _ in
            ThemeFonts(fonts: [
                .bold: { UIFont.systemFont(ofSize: $0, weight: .bold) },
                .light: { UIFont.systemFont(ofSize: $0, weight: .light) },
                .medium: { UIFont.systemFont(ofSize: $0, weight: .medium) },
                .regular: { UIFont.systemFont(ofSize: $0, weight: .regular) }
            ])
        }
        .inScope(InjectorScope.container)
    }
}

// MARK: UtilsAssembly
class UtilsAssembly: Assembly {
    func assemble(injector: Injector) {
        injector.register(HomeShortcutsProtocol.self) { _ in
            HomeShortcuts()
        }
        .inScope(InjectorScope.container)
    }
}
