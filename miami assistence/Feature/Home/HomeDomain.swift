//
//  HomeDomain.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 21/06/23.
//

import ComposableArchitecture

struct HomeDomain: ReducerProtocol {
    struct State: Equatable {
        var userType: UserType
    }

    enum Action: Equatable {
        case userType(UserType)
    }

    enum UserType {
        case anonymous
        case authenticated
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .userType(let userType):
                state.userType = userType
                return .none
            }
        }
    }
}
