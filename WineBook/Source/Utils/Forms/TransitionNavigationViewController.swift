//
//  TransitionNavigationViewController.swift
//  WineBook
//
//  Created by Konrad on 6/19/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import Forms
import FormsAnchor
import FormsTransitions
import FormsUtils
import UIKit

// MARK: TransitionNavigationViewController
class TransitionNavigationViewController: FormsNavigationController, TransitionableNavigation {
    var animator: TransitionNavigationAnimator = TransitionNavigationSlideHorizontalAnimator()
    var coordinator: TransitionNavigationCoordinator = TransitionNavigationCoordinator()
    var edgePanGesture: UIScreenEdgePanGestureRecognizer! = UIScreenEdgePanGestureRecognizer()
    
    override func postInit() {
        super.postInit()
        self.delegate = self.coordinator
    }
    
    override func setupActions() {
        super.setupActions()
        self.edgePanGesture.addTarget(self, action: #selector(handleTransitionBackSwipe))
        self.edgePanGesture.edges = .left
        self.view.addGestureRecognizer(self.edgePanGesture)
    }
    
    @objc
    func handleTransitionBackSwipe(recognizer: UIScreenEdgePanGestureRecognizer) {
        self.handleTransitionNavigationEdgePan(recognizer)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.loadView()
        viewController.viewDidLoad()
        DispatchQueue.main.async {
            super.pushViewController(viewController, animated: animated)
            guard let controller = viewController as? NavigationBarRefreshable else { return }
            controller.refreshNavigationBar()
        }
    }
}
