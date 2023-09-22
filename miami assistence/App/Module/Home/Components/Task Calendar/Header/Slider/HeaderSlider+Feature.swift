//
//  HeaderSlider+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 21/09/23.
//

import ComposableArchitecture
import Foundation

extension HeaderSlider {
    struct Feature: Reducer {
        struct State: Equatable {
            @BindingState var currentIndex: Int = 1
            
            var currentDate: Date
            var weekSlider: [[Date.Week]]
            var createWeek: Bool = false
        }
        
        enum Action: BindableAction, Equatable {
            case binding(BindingAction<State>)
            case onAppear
            case selectDate(Date)
            
            case paginateWeek
        }
        
        var body: some Reducer<State, Action> {
            BindingReducer()
            Reduce{ state, action in
                switch action {
                case .paginateWeek:
                    state.createWeek = false
                    
                    /// Safe Check
                    if state.weekSlider.indices.contains(state.currentIndex) {
                        if let firstDate = state.weekSlider[state.currentIndex].first?.date, state.currentIndex == 0 {
                            state.weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                            state.weekSlider.removeLast()
                            state.currentIndex = 1
                        }
                        
                        if let lastDate = state.weekSlider[state.currentIndex].last?.date, state.currentIndex == (state.weekSlider.count - 1)  {
                            state.weekSlider.append(lastDate.createNextWeek())
                            state.weekSlider.removeFirst()
                            state.currentIndex = (state.weekSlider.count - 2)
                        }
                    }
                    
                    return .none
                    
                case .selectDate(let date):
                    state.currentDate = date
                    
                    return .none
                    
                case .binding(\.$currentIndex):
                    
                    /// Creating When it reaches first/last Page
                    if state.currentIndex == 0 || state.currentIndex == (state.weekSlider.count - 1) {
                        state.createWeek = true
                    }
                    
                    return .none
                default:
                    return .none
                }
            }
        }
    }
}

