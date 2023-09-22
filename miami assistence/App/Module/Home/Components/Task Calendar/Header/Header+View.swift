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
            VStack(spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    IfLetStore(store.scope(state: \.today, action: Feature.Action.today)) {
                        HeaderToday.View(store: $0)
                    }
                    
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 4) {
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
                            Image(systemName: "gear")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(.gray)
                        }
                        .buttonStyle(.pressBordered)
                    }
                }
                .padding(.horizontal, 8)
                
                IfLetStore(store.scope(state: \.slider, action: Feature.Action.slider)) {
                    HeaderSlider.View(store: $0)
                }
            }
            .frame(maxWidth: .infinity)
            .background(
                Color.white
                    .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 2)
                    .ignoresSafeArea(.container, edges: .top)
            )
            
        }
        
    }
}
