//
//  Notifications.swift
//  FormsDemo
//
//  Created by Konrad on 6/13/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FirebaseCore
import FirebaseMessaging
import FormsNotifications
import FormsPermissions
import UIKit

// MARK: NotificationsFirebaseProvider
class NotificationsFirebaseProvider: NSObject, NotificationsProvider, MessagingDelegate, UNUserNotificationCenterDelegate {
    var onNewToken: NotificationsOnNewToken? = nil
    var onWillPresent: NotificationsOnWillPresent? = nil
    var onReceive: NotificationsOnReceive? = nil
    var onOpen: NotificationsOnOpen? = nil
    
    private var handledNotifications: Set<String> = []
    
    var badge: Int? {
        get { return UIApplication.shared.applicationIconBadgeNumber }
        set { UIApplication.shared.applicationIconBadgeNumber = newValue.or(0) }
    }
    
    override init() {
        super.init()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
    }
    
    func setAPNSToken(_ deviceToken: Data) {
        Messaging.messaging().setAPNSToken(deviceToken, type: MessagingAPNSTokenType.unknown)
    }
    
    func registerRemote() {
        Permissions.notifications.ask { (status) in
            DispatchQueue.main.async {
                guard status.isAuthorized else { return }
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func unregisterRemote() {
        UIApplication.shared.unregisterForRemoteNotifications()
    }
    
    func messaging(_ messaging: Messaging,
                   didReceiveRegistrationToken fcmToken: String) {
        self.onNewToken?(fcmToken)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        self.onReceiveIfNeeded(notification)
        let options: UNNotificationPresentationOptions = self.onWillPresent?(notification) ?? []
        completionHandler(options)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        self.onReceiveIfNeeded(response.notification)
        self.onOpen?(response)
        completionHandler()
    }
    
    private func onReceiveIfNeeded(_ notification: UNNotification) {
        if !self.handledNotifications.contains(notification.request.identifier) {
            self.handledNotifications.insert(notification.request.identifier)
            self.onReceive?(notification)
        }
    }
}
