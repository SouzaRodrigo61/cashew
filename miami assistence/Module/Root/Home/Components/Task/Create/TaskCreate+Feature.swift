//
//  TaskPlus+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 21/08/23.
//

import ComposableArchitecture
import Foundation
import SwiftUI

extension TaskCreate {
    struct Feature: Reducer {
        struct State: Equatable {
            @BindingState var title: String = ""
            
            @BindingState var color: Color = .clear
            @BindingState var date: Date = .now
            @BindingState var startedHour: Date = .now
            
            var activityDuration: Double = .zero
        }
        
        enum Action: BindableAction, Equatable, Sendable {
            case binding(BindingAction<State>)
            case createTaskTapped
            case closeTapped
        }
        
        var body: some Reducer<State, Action> {
            BindingReducer()
        }
    }
}
