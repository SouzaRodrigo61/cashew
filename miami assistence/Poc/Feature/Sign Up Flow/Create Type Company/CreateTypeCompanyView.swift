//
//  CreateTypeCompanyView.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 22/07/23.
//

import SwiftUI
import NavigationTransition

struct CreateTypeCompanyView: View {
    @Environment(\.dismiss) private var dismissAction: DismissAction
    
    @State private var typeCompany: String = ""
    @State private var typeCompanyValid: Bool = false
    @FocusState private var focus: Bool
    
    @State private var route: Bool = false
    
    
    var body: some View {
        VStack {
            Button {
                self.dismissAction.callAsFunction()
            } label: {
                Text("Back")
            }
            
            VStack(alignment: .center) {
                Text("Qual a area atuação da empresa ?")
                    .foregroundStyle(.miamiBlack)
                    .font(.title3)
                
                SizedBox(height: 8)
                
                TextField("", text: $typeCompany, prompt: Text("Area atuação da empresa"))
                    .font(.title)
                    .fontWeight(.semibold)
                    .focused($focus, equals: true)
                    .frame(height: 54)
                    .foregroundStyle(.miamiBlack)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .hSpacing(.center)
                    .submitLabel(.continue)
                    .onChange(of: typeCompany) { oldValue, newValue in
                        withAnimation {
                            if typeCompany.count >= 3 {
                                typeCompanyValid = true
                            } else {
                                typeCompanyValid = false
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
            .background(.miamiBlack.opacity(typeCompanyValid == false ? 0.35 : 1), in: .rect(cornerRadius: 12))
            .padding([.horizontal, .bottom])
            .disabled(typeCompanyValid == false)
            .navigationDestination(isPresented: $route, destination: {
//                CreateTypeCompanyView()
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
    CreateTypeCompanyView()
}
