//
//  miami_assistenceApp.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 15/06/23.
//

import SwiftUI

@main
struct MiamiAssistenceApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            GeometryReader {
                let safeArea = $0.safeAreaInsets
                let size = $0.size
                
                NavigationStack {
                    HomeView(safeArea: safeArea, size: size)
                        .ignoresSafeArea(.container, edges: [.top, .bottom])
                }
            }
        }
    }
}
