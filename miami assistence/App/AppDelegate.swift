//
//  AppDelegate.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 27/06/23.
//

import SwiftUI
import OneSignal
import FirebaseCore
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()

        // Remove this method to stop OneSignal Debugging
//        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        
        
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId("6691ab8a-ba15-4a95-9f45-4b81a19bb214")
        
        OneSignal.promptForPushNotifications(userResponse: { accepted in
//            dump("User accepted notification: \(accepted)")
        })
        
        // Set your customer userId
        // OneSignal.setExternalUserId("userId")
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
}
