//
//  Sign Up Navigation.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 22/07/23.
//

import SwiftUI

struct SignUpNavigation: Identifiable, Hashable {
    var id = UUID()
    var flow: FlowNavigation
    
    enum FlowNavigation: String {
        case createCompany
        case createTypeCompany
        case showPaid
    }
    
    static let signUpNavigationFlow: [SignUpNavigation] = [
        .init(flow: .createCompany),
        .init(flow: .createTypeCompany),
        .init(flow: .showPaid)
    ]
}
