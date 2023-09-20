//
//  Home+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture
import SwiftUI


struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension Home {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        @State private var currentIndex: Int = 1
        @State private var createWeek: Bool = false
        
        var body: some SwiftUI.View {
            
            NavigationStack {
                NavigationStackStore(store.scope(state: \.destination, action: Feature.Action.destination)) {
                    TaskCalendar.View(store: store.scope(state: \.taskCalendar, action: Feature.Action.taskCalendar))
                        .transition(.scale)
                        .onAppear {
                            UIToolbar.changeAppearance(clear: true)
                            store.send(.onAppear)
                        }
                        .overlay {
                            IfLetStore(store.scope(state: \.taskCreate, action: Feature.Action.taskCreate)) {
                                TaskCreate.View(store: $0)
                            }
                            .background(.white)
                            .transition(.move(edge: .top))
                        }
                    
                } destination: {
                    switch $0 {
                    case .search:
                        CaseLet(/Destination.State.search, action: Destination.Action.search) {
                            Search.View(store: $0)
                        }
                        
                    case .settings:
                        CaseLet(/Destination.State.settings, action: Destination.Action.settings) {
                            Settings.View(store: $0)
                        }
                        
                    case .note:
                        CaseLet(/Destination.State.note, action: Destination.Action.note) {
                            Note.View(store: $0)
                        }
                    }
                }
                .sheet(store: store.scope(state: \.$schedule, action: Feature.Action.schedule)) { store in
                    Schedule.View(store: store)
                        .presentationDetents([.medium])
                }
            }
            .overlayPreferenceValue(MAnchorKey.self) { value in
                GeometryReader { geo in
                    WithViewStore(store, observe: { $0 } ) { viewStore in
                        
                        if let task = viewStore.state.contentTask, let anchor = value[task.id.uuidString] {
                            TaskItem.Content(id: task.id, title: task.title, color: Color.clear, showOverlay: false, forcePadding: viewStore.state.forcePadding)
                                .frame(width: geo[anchor].width, height: geo[anchor].height)
                                .offset(x: geo[anchor].minX, y: geo[anchor].minY)
                                .animation(.snappy(duration: 0.35, extraBounce: 0), value: geo[anchor])
                        }
                    }
                }
            }
        }
    }
}

