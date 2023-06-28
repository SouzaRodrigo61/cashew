//
//  ContentView.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 15/06/23.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    
    private func showAppleLoginView() {
        // 1. Instantiate the AuthorizationAppleIDProvider
        let provider = ASAuthorizationAppleIDProvider()
        // 2. Create a request with the help of provider - ASAuthorizationAppleIDRequest
        let request = provider.createRequest()
        // 3. Scope to contact information to be requested from the user during authentication.
        request.requestedScopes = [.fullName, .email]
        // 4. A controller that manages authorization requests created by a provider.
        let controller = ASAuthorizationController(authorizationRequests: [request])
        // 6. Initiate the authorization flows.
        controller.performRequests()
    }
    
    var body: some View {
        GeometryReader {
            VStack(alignment: .center) {
                Text("by_user".localized(args: "Rodrigo", "Abestado"))
                    .font(.largeTitle)
                    .foregroundStyle(Color("miami-darkPurple"))
                    .accessibilityLabel("by_user".localized(args: "Rodrigo", "Abestado"))
                
                Spacer()
                
                QuickSignInWithApple()
                    .padding(.horizontal, 16)
                    .frame(height: 54)
                    .onTapGesture(perform: showAppleLoginView)
            }
            .frame(width: $0.size.width)
            .background(.miamiWhite)
        }
    }
}

#Preview {
    LoginView()
}
