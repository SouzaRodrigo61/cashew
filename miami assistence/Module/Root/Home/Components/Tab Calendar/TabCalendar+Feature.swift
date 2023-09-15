//
//  TabCalendar+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 14/09/23.
//

import Foundation
import ComposableArchitecture

extension TabCalendar {
    struct Feature: Reducer {
        struct State: Equatable {
            var weekSlider: [Date.Days] = Date().fetchWeek()
            var currentDate: Date = .init()
            var currentIndex: Int = 1
            
            var createDay: Bool = false
        }
        
        enum Action: Equatable {
            case nextDay(Date)
            case previousDay(Date)
            
            
            case tabSelected(Int)
            
            
            case onAppear
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
