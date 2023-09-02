//
//  BottomSheet+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 18/08/23.
//

import ComposableArchitecture
import SwiftUI

extension BottomSheet {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            WithViewStore(store, observe: \.collapse) { viewStore in
                HStack(alignment: .center) {
                    Button {
                        store.send(.buttonTapped, animation: .snappy)
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.largeTitle)
                            .foregroundStyle(.aliceBlue)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    Button {
                        store.send(.addButtonTapped, animation: .snappy)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.royalBlue)
                    }
                    
                }
                .padding(.top, 8)
                .padding(.horizontal, 16)
                .frame(height: viewStore.state ? 400 : 100, alignment: .top)
                .frame(maxWidth: .infinity)
                .background(.gunmetal, in: .rect(cornerRadius: viewStore.state ? 16 : 0))
            }
        }
    }
}
