//
//  AppDelegate.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 27/06/23.
//

import SwiftUI
import OneSignalFramework
import ComposableArchitecture

extension CoreApp {
    class Delegate: NSObject, UIApplicationDelegate {
        
        static let shared = Delegate()
        let store = Store(
            initialState: Feature.State(),
            reducer: {
                Feature()
            }
        )
        
        func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
        ) -> Bool {
            store.send(.didFinishLaunching)
            
            return true
        }

    }
    
}

