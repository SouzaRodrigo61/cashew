//
//  Onboarding+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture
import SwiftUI

extension Onboarding {
    
    struct View: SwiftUI.View {
        let path: StoreOf<Destination>
        
        var body: some SwiftUI.View {
            NavigationStackStore(self.path.scope(state: \.path, action: Destination.Action.path)) {
                VStack {
                    Text(
                          """
                          This screen demonstrates a basic feature hosted in a navigation stack.
                          
                          You can also have the child feature dismiss itself, which will communicate back to the \
                          root stack view to pop the feature off the stack.
                          """
                    )
                    .padding(.horizontal)
                    Spacer()
                    
                    Button {
                        path.send(.moveToCreateCompany)
                    } label : {
                        HStack {
                            Image(systemName: "star")
                            Text("Star system name")
                        }
                    }
                    .foregroundStyle(.miamiWhite)
                    .padding()
                    .background(.miamiBlack, in: .rect(cornerRadius: 16))
                }
                .toolbar(.hidden, for: .navigationBar)
            } destination: {
                SwitchStore($0) { state in
                    switch state {
                    case .createCompany:
                        CaseLet(
                            state: /Destination.Path.State.createCompany,
                            action: Destination.Path.Action.createCompany,
                            then: CreateCompany.View.init(path:)
                        )
                    case .createTypeCompany:
                        CaseLet(
                            state: /Destination.Path.State.createTypeCompany,
                            action: Destination.Path.Action.createTypeCompany,
                            then: CreateTypeCompany.View.init(path:)
                        )
                    }
                }
            }
        }
    }
}
