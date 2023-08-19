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
            HStack(alignment: .center) {
                Image(systemName: "line.3.horizontal")
                    .font(.title)
                    .foregroundStyle(.aliceBlue)
                    .fontWeight(.bold)
                
                Spacer()
                
                HStack {
                    
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.aliceBlue)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.aliceBlue)
                        .frame(width: 30, height: 4)
                        .padding(.horizontal, 16)
                    
                    Image(systemName: "arrow.right")
                        .foregroundStyle(.aliceBlue)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .onTapGesture {
                    // On Tapped Gesture this action make 
                }
                
                Spacer()
                
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundStyle(.royalBlue)
                
            }
            .padding(.top, 8)
            .padding(.horizontal, 16)
            .frame(height: 80, alignment: .top)
            .frame(maxWidth: .infinity)
            .background(.gunmetal)
        }
    }
}


//#Preview {
//    BottomSheet.View(store: .init(initialState: .init(), reducer: {
//        BottomSheet.Feature()
//    }))
//}
