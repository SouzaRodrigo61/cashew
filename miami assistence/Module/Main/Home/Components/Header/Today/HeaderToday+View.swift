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
            WithViewStore(store, observe: { $0 }) { viewStore in
                Button {
                    store.send(.buttonTapped)
                } label: {
                    HStack(alignment: .center) {
                        Image(systemName: "calendar")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.royalBlue)
                        
                        HStack(alignment: .bottom) {
                            Text("Hoje")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                            Text("qui. 17 de ago.")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .buttonStyle(.scale)
            }
        }
    }
}
