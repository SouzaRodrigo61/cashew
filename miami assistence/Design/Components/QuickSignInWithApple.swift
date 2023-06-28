//
//  QuickSignInWithApple.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 25/06/23.
//

import SwiftUI
import AuthenticationServices

struct QuickSignInWithApple: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme
    
    typealias UIViewType = ASAuthorizationAppleIDButton
    
    func makeUIView(context: Context) -> UIViewType {
        return ASAuthorizationAppleIDButton(type: .signIn, style: colorScheme == .dark ? .white : .black)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}

#Preview {
    QuickSignInWithApple()
        .frame(width: 120, height: 44)
}
