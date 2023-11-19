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
            GeometryReader { geo in
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(.white)
                        .frame(height: geo.safeAreaInsets.top + 50)
                    
                    HStack(alignment: .center, spacing: 0) {
                        IfLetStore(store.scope(state: \.today, action: Feature.Action.today)) {
                            HeaderToday.View(store: $0)
                        }
                        .hSpacing(.leading)
                        
                        Spacer()
                        
                        IfLetStore(store.scope(state: \.button, action: Feature.Action.button)) {
                            HeaderButton.View(store: $0)
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.bottom, 8)
                    
    //                IfLetStore(store.scope(state: \.goal, action: Feature.Action.goal)) {
    //                    HeaderGoalProgress.View(store: $0)
    //                }
    //                .padding(.horizontal, 8)
                    
                    IfLetStore(store.scope(state: \.slider, action: Feature.Action.slider)) {
                        HeaderSlider.View(store: $0)
                    }
                    .padding(.horizontal, 8)
                    
                    Divider()
                }
                .frame(maxWidth: .infinity)
                .background(.white)
            }
        }
        
    }
}
