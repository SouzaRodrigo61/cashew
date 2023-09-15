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
    
    static func  reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
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
                
                    ZStack(alignment: .bottomTrailing) {
                        WithViewStore(store, observe: \.tabCalendar) { viewStore in
                            
                            TabView(
                                selection: viewStore.binding(
                                    get: \.currentIndex,
                                    send: Feature.Action.tabSelected
                                )
                            ) {
                                ForEach(viewStore.weekSlider.indices, id: \.self) { index in
                                    VStack(spacing: 0) {
                                        Text(viewStore.weekSlider[index].date.description)
                                        
                                        IfLetStore(store.scope(state: \.header, action: Feature.Action.header)) {
                                            Header.View(store: $0)
                                        }
                                        
                                        IfLetStore(store.scope(state: \.task, action: Feature.Action.task)) {
                                            Task.View(store: $0)
                                        }
                                    }
                                    .tag(index)
                                    .background {
                                        GeometryReader { geo in
                                            let minX = geo.frame(in: .global).minX
                                            
                                            Color.clear
                                                .preference(key: OffsetKey.self, value: minX)
                                                .onPreferenceChange(OffsetKey.self) { value in
                                                    /// When the Offset reaches 15 and if the createWeek is toggle then simply generating next set of week
                                                    
                                                    if viewStore.currentIndex == 0 && value.rounded() == 15 && viewStore.createDay {
                                                        let day = viewStore.weekSlider[0].date
                                                        store.send(.tabCalendar(.previousDay(day)))
                                                    }
                                                    
                                                    if viewStore.currentIndex == 2 && value.rounded() == -15 && viewStore.createDay {
                                                        let day = viewStore.weekSlider[2].date
                                                        store.send(.tabCalendar(.nextDay(day)))
                                                    }
                                                }
                                        }
                                    }
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            
                        }
                        IfLetStore(store.scope(state: \.bottomSheet, action: Feature.Action.bottomSheet)) {
                            BottomSheet.View(store: $0)
                        }
                    }

                    .transition(.scale)
                    .onAppear {
                        UIToolbar.changeAppearance(clear: true)
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
                            TaskItem.Content(id: task.id, title: task.title, color: task.color, showOverlay: false, forcePadding: viewStore.state.forcePadding)
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

