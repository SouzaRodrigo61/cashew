//
//  TabCalendar+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 14/09/23.
//

import Foundation
import ComposableArchitecture

extension TaskCalendar {
    struct Feature: Reducer {
        struct State: Equatable {
            var task: Task.Feature.State?
            var header: Header.Feature.State?
            var weekSlider: [Date.Days] = Date().fetchWeek()
            var currentDate: Date = .now
            var currentIndex: Int = 1
            
            var createDay: Bool = false
        }
        
        enum Action: Equatable {
            
            case task(Task.Feature.Action)
            case header(Header.Feature.Action)
            
            case nextDay(Date)
            case previousDay(Date)
            case tabSelected(Int)
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
