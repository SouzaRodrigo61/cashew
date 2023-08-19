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
            HStack(alignment: .center, spacing: 0) {
                Button {
                    store.send(.todayTapped)
                } label: {
                    HStack(alignment: .center) {
                        Image(systemName: "calendar")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.royalBlue)
                        
                        HStack(alignment: .bottom) {
                            Text("Hoje")
                                .font(.title)
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
    }
}
