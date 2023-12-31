//
//  miami_assistenceApp.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 15/06/23.
//

import SwiftUI

@main
struct MiamiAssistenceApp: App {
    @UIApplicationDelegateAdaptor(CoreApp.Delegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            Root.build()
                .preferredColorScheme(.light)
        }
    }
}
