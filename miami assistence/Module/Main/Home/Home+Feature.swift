//
//  Home+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture

extension Home {
    struct Feature: Reducer {
        struct State: Equatable {
            var task: Task.Feature.State?
            var header: Header.Feature.State?
            var bottomSheet: BottomSheet.Feature.State?
        }
        
        enum Action: Equatable {
            case task(Task.Feature.Action)
            case header(Header.Feature.Action)
            case bottomSheet(BottomSheet.Feature.Action)
            
            case buttonTapped
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
                .ifLet(\.task, action: /Action.task) {
                    Task.Feature()
                }
                .ifLet(\.header, action: /Action.header) {
                    Header.Feature()
                }
                .ifLet(\.bottomSheet, action: /Action.bottomSheet) {
                    BottomSheet.Feature()
                }
        }
    }
}
