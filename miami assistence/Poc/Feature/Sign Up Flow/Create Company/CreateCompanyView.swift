//
//  OnboardingView.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 13/07/23.
//

import SwiftUI
import NavigationTransitions

struct CreateCompanyView: View {
    @State private var username: String = ""
    @State private var usernameValid: Bool = false
    @FocusState private var focus: Bool
    
    @State private var route: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Text("Qual nome da sua empresa ?")
                    .foregroundStyle(.miamiBlack)
                    .font(.title3)
                
                SizedBox(height: 8)
                
                TextField("", text: $username, prompt: Text("Nome da sua empresa"))
                    .font(.title)
                    .fontWeight(.semibold)
                    .focused($focus, equals: true)
                    .frame(height: 54)
                    .foregroundStyle(.miamiBlack)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .hSpacing(.center)
                    .submitLabel(.continue)
                    .onChange(of: username) { oldValue, newValue in
                        withAnimation {
                            if username.count >= 3 {
                                usernameValid = true
                            } else {
                                usernameValid = false
                            }
                        }
                    }
                    .keyboardType(.alphabet)
                    .disableAutocorrection(true)
                    .textContentType(.oneTimeCode)
            }
            .vSpacing(.center)
            .padding()
            
            Button {
                route.toggle()
            } label: {
                Text("Continuar")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding()
                    .hSpacing(.center)
                    .foregroundStyle(.miamiWhite)
            }
            .background(.miamiBlack.opacity(usernameValid == false ? 0.35 : 1), in: .rect(cornerRadius: 12))
            .padding([.horizontal, .bottom])
            .disabled(usernameValid == false)
            .navigationDestination(isPresented: $route, destination: {
                CreateTypeCompanyView()
            })
        }
        .navigationTransition(
            .fade(.cross).animation(.easeInOut(duration: 0.3))
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.focus = true
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .background(.miamiWhite)
        .hSpacing(.leading)
    }
}

#Preview {
    CreateCompanyView()
}
