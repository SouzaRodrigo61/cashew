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
            @BindingState var tag: Tag.Model = .init(value: "")
            
            @BindingState var color: Color = .blush
            @BindingState var date: Date
            @BindingState var startedHour: Int = Date().fetchIndexByDeviceHour()
            
            @BindingState var activityDuration: ActivityDuration = .OneHour
            
            var selectedHour: String = ""
            
            var hours: [String] = Date().fetchHourOfDay()
            
            var tags: [Tag.Model] = []
            
            enum ActivityDuration : Int, CaseIterable {
                case FifteenMinutes = 15
                case ThirtyMinutes = 30
                case OneHour = 60
                case HalfHour = 90
            }
        }
        
        enum Action: BindableAction, Equatable, Sendable {
            case binding(BindingAction<State>)
            case createTaskTapped
            case closeTapped
            
            case onAppearSelectedHour
            
            case hourTapped
            case dateTapped
        }
        
        var body: some Reducer<State, Action> {
            BindingReducer()
            Reduce { state, action in
                switch action {
                case .binding(\.$tag):
                    dump(state.tag, name: "Tag")
                    return .none
                case .binding(\.$startedHour):
                    return selectedHour(into: &state)
                case .binding(\.$activityDuration):
                    return selectedHour(into: &state)
                case .onAppearSelectedHour:
                    return selectedHour(into: &state)
                default:
                    return .none
                }
            }
        }
        
        
        private func selectedHour(into state: inout State) -> Effect<Action> {
            let hour = state.hours[state.startedHour]
            let finishHour = hour.calculateHourByValue(with: state.activityDuration.rawValue)
    
            state.selectedHour = "\(hour) - \(finishHour)"
            
            return .none
        }
    }
}
