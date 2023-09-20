//
//  HeaderToday+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 19/08/23.
//

import SwiftUI
import ComposableArchitecture

extension HeaderToday {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            Button {
                store.send(.buttonTapped)
            } label: {
                HStack(alignment: .center) {
                    Image(systemName: "calendar")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.royalBlue)
                    
                    HStack(alignment: .bottom) {
                        WithViewStore(store, observe: \.week) { viewStore in
                            Text(viewStore.state.localized)
                                .font(.system(.title2, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                        }
                        WithViewStore(store, observe: \.weekCompleted) { viewStore in
                            Text(viewStore.state)
                                .font(.system(.title3, design: .rounded))
                                .fontWeight(.semibold)
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
            .buttonStyle(.scale)
        }
    }
}
