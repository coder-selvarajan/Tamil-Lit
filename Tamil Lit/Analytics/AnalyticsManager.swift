//
//  AnalyticsManager.swift
//  Tamil Lit
//
//  Created by Selvarajan on 01/09/24.
//

import Foundation
import TelemetryDeck
import UIKit
import STAnalytics

final class AnalyticsManager: STAnalyticsEventHandler {
    func sendAnalyticsEvent(name eventName: String, parameters: [String : String]?) {
        // Add additional parameters if any
        var modifiedParameters = parameters ?? [:]
        modifiedParameters["app"] = "Tamil Lit"
        
        TelemetryDeck.signal(eventName, parameters: modifiedParameters)
    }
    
    static let shared = AnalyticsManager()
    
    private init() {
        let config = TelemetryDeck.Config(appID: "1C8C778D-C7DA-49BD-AD34-D6396724E6D2")
        TelemetryDeck.initialize(config: config)
    }
    
    func logEvent(_ eventName: String, parameters: [String: String]) {
        TelemetryDeck.signal(eventName, parameters: parameters)
    }
    
    func logScreenView(screenName: String) {
        logEvent("ScreenView", parameters: ["ScreenName": screenName])
    }
    
    func logActionEvent(action: String, label: String? = nil) {
        var properties: [String: String] = ["Action": action]
        if let label = label {
            properties["Label"] = label
        }
        logEvent("ActionEvent", parameters: properties)
    }
    
    func logErrorEvent(message: String) {
        logEvent("ErrorEvent", parameters: ["ErrorMessage": message])
    }
}

extension UIApplication {

    @objc dynamic func newSendEvent(_ event: UIEvent) {
        newSendEvent(event)
        
        let touches: Set<UITouch> = event.allTouches!
        let touch: UITouch = touches.first!
        
        if touch.phase == .began {
            let touchBeginCoordinates = touch.location(in: touch.view)
            
            let swiftUITracker = SwiftUITracker(analyticsEventHandler: AnalyticsManager.shared)
            swiftUITracker.processEvent(touch: touch, touchBeginCoordinates: touchBeginCoordinates)
        }
    }
}
