//
//  Header+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 18/08/23.
//

import ComposableArchitecture
import SwiftUI

extension Header {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            WithViewStore(store, observe: \.isScroll) { viewStore in
                VStack {
                    HStack(alignment: .center, spacing: 0) {
                        IfLetStore(store.scope(state: \.today, action: Feature.Action.today)) {
                            HeaderToday.View(store: $0)
                        }
                        
                        Spacer()
                        
                        HStack(alignment: .center, spacing: 0) {
                            Button {
                                store.send(.searchTapped)
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.gray)
                            }
                            .buttonStyle(.pressBordered)
                            
                            Button {
                                store.send(.moreTapped)
                            } label: {
                                Image(systemName: "ellipsis")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.gray)
                                    .padding(.vertical, 4)
                            }
                            .buttonStyle(.pressBordered)
                        }
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                }
                .frame(maxWidth: .infinity)
                .background(
                    Rectangle()
                        .foregroundStyle(.white)
                        .shadow(color: viewStore.state ? .gray.opacity(0.2) : .clear, radius: viewStore.state ? 4 : 0, x: 0, y: 6)
                    .ignoresSafeArea(.container, edges: .top)
                )
                
            }
        }
    }
}
