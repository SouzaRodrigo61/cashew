//
//  Header+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 18/08/23.
//

import Foundation
import ComposableArchitecture

extension Header {
    struct Feature: Reducer {
        struct State: Equatable {
            var today: HeaderToday.Feature.State?
            var slider: HeaderSlider.Feature.State?
            var button: HeaderButton.Feature.State?
            var goal: HeaderGoalProgress.Feature.State?
            var isScroll: Bool = false
        }
        
        enum Action: Equatable {
            case today(HeaderToday.Feature.Action)
            case slider(HeaderSlider.Feature.Action)
            case button(HeaderButton.Feature.Action)
            case goal(HeaderGoalProgress.Feature.Action)
            case searchTapped
            case moreTapped
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
                .ifLet(\.today, action: /Action.today) {
                    HeaderToday.Feature()
                }
                .ifLet(\.slider, action: /Action.slider) {
                    HeaderSlider.Feature()
                }
                .ifLet(\.button, action: /Action.button) {
                    HeaderButton.Feature()
                }
                .ifLet(\.goal, action: /Action.goal) {
                    HeaderGoalProgress.Feature()
                }
        }
    }
}
