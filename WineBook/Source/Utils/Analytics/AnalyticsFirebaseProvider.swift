//
//  AnalyticsFirebaseProvider.swift
//  FormsDemo
//
//  Created by Konrad on 6/13/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FirebaseAnalytics
import FormsAnalytics

// MARK: AnalyticsFirebaseProvider
class AnalyticsFirebaseProvider: AnalyticsProvider {
    let name: String = "Firebase"
    
    func logEvent(_ event: AnalyticsEvent,
                  _ parameters: [String: Any],
                  _ userProperties: [String: String]) {
        for userProperty in userProperties {
            FirebaseAnalytics.Analytics.setUserProperty(
                userProperty.value,
                forName: userProperty.key)
        }
        FirebaseAnalytics.Analytics.logEvent(
            event.name,
            parameters: parameters)
    }
    
    func setUserId(_ userId: String?) {
        FirebaseAnalytics.Analytics.setUserID(userId)
    }
}
