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
            @BindingState var focus: Field? = .taskName
            @BindingState var title: String
            @BindingState var tag: Tag.Model
            @BindingState var color: Color
            @BindingState var date: Date
            @BindingState var startedHour: Int
            @BindingState var tags: [Tag.Model]
            @BindingState var activityDuration: ActivityDuration
            
            var selectedHour: String
            
            var hours: [String]
            var hour: String
            
            enum ActivityDuration : Int, CaseIterable {
                case FifteenMinutes = 15
                case ThirtyMinutes = 30
                case OneHour = 60
                case HalfHour = 90
            }
            
            enum Field: Hashable {
                case taskName
                case tag(Tag.Model.ID)
            }
            
            init(title: String = "",
                 tag: Tag.Model = .init(value: ""),
                 color: Color  = .blush,
                 date: Date,
                 startedHour: Int = 0,
                 activityDuration: ActivityDuration  = .OneHour,
                 selectedHour: String = "",
                 hours: [String] = [],
                 tags: [Tag.Model] = [
                    .init(value: "")
                 ]
            ) {
                self.title = title
                self.tag = tag
                self.color = color
                self.date = date
                self.activityDuration = activityDuration
                self.selectedHour = selectedHour
                
                self.tags = tags
                
                self.hours = date.fetchHourOfDay()
                self.startedHour = date.fetchIndexByDeviceHour()
                self.hour = ""
            }
        }
        
        enum Action: BindableAction, Equatable, Sendable {
            case binding(BindingAction<State>)
            case createTaskTapped
            case closeTapped
            
            case onAppearSelectedHour
            
        }
        
        
        var body: some Reducer<State, Action> {
            BindingReducer()
            Reduce { state, action in
                switch action {
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
            if !state.hours.isEmpty {
                let hour = state.hours[state.startedHour]
                let finishHour = hour.calculateHourByValue(with: state.activityDuration.rawValue)
        
                state.selectedHour = "\(hour) - \(finishHour)"
                state.hour = hour
            } else {
                state.selectedHour = ""
            }

            return .none
        }
    }
}
