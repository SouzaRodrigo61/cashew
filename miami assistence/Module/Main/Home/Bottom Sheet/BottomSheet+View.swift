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
            WithViewStore(store, observe: { $0 }) { viewStore in
                HStack(alignment: .center) {
                    Button {
                        store.send(.buttonTapped, animation: .snappy)
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title)
                            .foregroundStyle(.aliceBlue)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    Button {
                        // On Tapped Gesture this action make
                        store.send(.changeHeightTapped, animation: .smooth)
                    } label: {
                        HStack(spacing: 0) {
                            Image(systemName: "arrow.left")
                            
                            Image(systemName: viewStore.state.collapse
                                  ? "chevron.compact.down"
                                  : "chevron.compact.up")
                            .frame(width: 30)
                             
                            .padding(.horizontal, 8)
                            Image(systemName: "arrow.right")
                        }
                        .frame(height: 20)
                        .foregroundStyle(.aliceBlue)
                        .font(.title2)
                        .fontWeight(.bold)

                    }                    
                    .buttonStyle(.scale)
                    
                    Spacer()
                    
                    Button {
                        store.send(.addButtonTapped, animation: .snappy)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundStyle(.royalBlue)
                    }
                    
                }
                .padding(.top, 8)
                .padding(.horizontal, 16)
                .frame(height: viewStore.state.collapse ? 400 : 80, alignment: .top)
                .frame(maxWidth: .infinity)
                .background(.gunmetal)
            }
        }
    }
}

#Preview {
    BottomSheet.View(store: .init(initialState: .init(), reducer: {
        BottomSheet.Feature()
    }))
}
