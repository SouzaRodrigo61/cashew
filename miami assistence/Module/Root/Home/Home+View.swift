//
//  Home+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture
import SwiftUI

extension Home {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            
            NavigationStackStore(store.scope(state: \.destination, action: Feature.Action.destination)) {
                
                VStack(spacing: 0) {
                    IfLetStore(store.scope(state: \.header, action: Feature.Action.header)) {
                        Header.View(store: $0)
                    }
                    
                    IfLetStore(store.scope(state: \.task, action: Feature.Action.task)) {
                        Task.View(store: $0)
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        IfLetStore(store.scope(state: \.bottomSheet, action: Feature.Action.bottomSheet)) {
                            BottomSheet.View(store: $0)
                        }
                    }
                }
                .onAppear {
                    UIToolbar.changeAppearance(clear: true)
                }
                
            } destination: {
                switch $0 {
                case .note:
                    CaseLet(
                        /Destination.State.note,
                         action: Destination.Action.note,
                         then: Note.View.init(store:)
                    )
                }
            }
            .sheet(store: store.scope(state: \.$taskCreate, action: Feature.Action.taskCreate)) { store in
                TaskCreate.View(store: store)
            }
            .sheet(store: store.scope(state: \.$schedule, action: Feature.Action.schedule)) { store in
                Schedule.View(store: store)
                    .presentationDetents([.medium])
            }
            
            
        }
    }
}


extension UIToolbar {
    static func changeAppearance(clear: Bool) {
        let appearance = UIToolbarAppearance()
        
        if clear {
            appearance.configureWithOpaqueBackground()
        } else {
            appearance.configureWithDefaultBackground()
        }

        // customize appearance for your needs here
        appearance.shadowColor = .clear
//         appearance.backgroundColor = .clear
        appearance.backgroundImage = UIImage(named: "imageName")
        
        UIToolbar.appearance().standardAppearance = appearance
        UIToolbar.appearance().compactAppearance = appearance
        UIToolbar.appearance().scrollEdgeAppearance = appearance
    }
}
