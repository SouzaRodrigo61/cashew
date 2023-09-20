//
//  TaskDetails+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/08/23.
//

import ComposableArchitecture
import SwiftUI

extension Note {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            GeometryReader { geo in
                WithViewStore(store, observe: \.task) { viewStore in
                    LazyVStack {
                        
                        Section {
                            Text(viewStore.title)
                            Text("Data: \(viewStore.date.description)")
                            Text("Hour: \(viewStore.startedHour.description)")
                            Text("Duration: \(viewStore.duration.description)")
                        } header: {
                            VStack {
                                WithViewStore(store, observe: \.showContent) {
                                    if $0.state {
                                        VStack {
                                            TaskItem.View.Content(id: viewStore.id, title: viewStore.title, color: Color.clear, alignment: .topLeading, showOverlay: false)
                                        }
                                        .overlay(alignment: .topTrailing) {
                                            Button {
                                                store.send(.closeTapped, animation: .linear)
                                            } label: {
                                                Image(systemName: "xmark.circle.fill")
                                                    .font(.title2)
                                                    .foregroundStyle(.gray)
                                            }
                                            .padding(8)
                                        }
                                    } else {
                                        Color.clear
                                    }
                                }
                            }
                            .frame(minHeight: 40, alignment: .leading)
                            .anchorPreference(key: MAnchorKey.self, value: .bounds) { anchor in
                                [viewStore.id.uuidString: anchor]
                            }
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .top)
                    .background(viewStore.color)
                    .toolbar(.hidden, for: .navigationBar)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            store.send(.onAppear, animation: .linear(duration: 0.5))
                        }
                    }
                    
                }
            }
            
        }
    }
}
