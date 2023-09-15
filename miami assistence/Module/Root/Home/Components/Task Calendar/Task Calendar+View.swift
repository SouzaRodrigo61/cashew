//
//  Task Calendar+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 15/09/23.
//

import SwiftUI
import ComposableArchitecture

extension TaskCalendar {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            WithViewStore(store, observe: { $0 }) { viewStore in
                TabView(
                    selection: viewStore.binding(
                        get: \.currentIndex,
                        send: Feature.Action.tabSelected
                    )
                ) {
                    ForEach(viewStore.weekSlider.indices, id: \.self) { index in
                        
                        VStack(spacing: 0) {
                            IfLetStore(store.scope(state: \.header, action: Feature.Action.header)) {
                                Header.View(store: $0)
                            }
                            
                            // TODO: Task date with list
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
                                        
                                        // TODO: Move this code for composable
                                        if viewStore.state.currentIndex == 0
                                            && (value.rounded() >= 15 && value.rounded() <= 20)
                                            && viewStore.state.createDay {
                                            let day = viewStore.state.weekSlider[0].date
                                            store.send(.previousDay(day))
                                        }
                                        
                                        if viewStore.state.currentIndex == (viewStore.state.weekSlider.count - 1)
                                            && (value.rounded() <= -15 && value.rounded() >= -20)
                                            && viewStore.state.createDay {
                                            let day = viewStore.state.weekSlider[(viewStore.state.weekSlider.count - 1)].date
                                            store.send(.nextDay(day))
                                        }
                                    }
                            }
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
        }
    }
}
