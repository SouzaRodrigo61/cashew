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
            
            var bottomSheet: BottomSheet.Feature.State?
            var taskCreate: TaskCreate.Feature.State?
            
            var task: Task.Feature.State?
            var header: Header.Feature.State?
            
            var tasks: [Task.Model] = []
            
            var contentTask: Task.Model?
            
            /// Custom Matched Geometry Animation
            var forcePadding: Bool = false
            var currentDate: Date = .now
        }
        
        enum Action: Equatable {
            case matcheAnimationRemoved
            case onAppear
            case loadedData([Task.Model])
            case saveNewTask([Task.Model])
            
            case task(Task.Feature.Action)
            case header(Header.Feature.Action)
            case bottomSheet(BottomSheet.Feature.Action)
            case taskCreate(TaskCreate.Feature.Action)
            
        }
        
        @Dependency(\.storeManager.load) var loadData
        @Dependency(\.storeManager.save) var saveData
        
        var body: some Reducer<State, Action> {
            Reduce { state, action in
                switch action {
                case .header(.slider(.selectDate(let date))):
                    guard state.header?.today != nil else { return .none }
                    
                    state.header?.today?.week = date.validateIsToday()
                    state.header?.today?.weekCompleted = date.week()
                    
                    state.currentDate = date
                    
                    
                    return .run { send in
                        enum CancelID { case saveDebounce }
                        do {
                            try await withTaskCancellation(id: CancelID.saveDebounce, cancelInFlight: true) {
                                let tasks = try JSONDecoder().decode([Task.Model].self, from: loadData(.tasks))
                                await send(.loadedData(tasks), animation: .default)
                            }
                        } catch {
                            dump("Error for loaded \(error.localizedDescription)")
                        }
                    }
                default:
                    return .none
                }
            }
            
            Reduce(self.bottomSheet)
            Reduce(self.taskCreate)
            Reduce(self.taskCalendar)
            
                .ifLet(\.header, action: /Action.header) {
                    Header.Feature()
                }
                .ifLet(\.task, action: /Action.task) {
                    Task.Feature()
                }
                .ifLet(\.bottomSheet, action: /Action.bottomSheet) {
                    BottomSheet.Feature()
                }
                .ifLet(\.taskCreate, action: /Action.taskCreate) {
                    TaskCreate.Feature()
                }
        }
        
        private func taskCalendar(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            case .onAppear:
                // TODO: Move this code for resueble
                var weekSlider: [[Date.Week]] = []
                let currentWeek = state.currentDate.fetchWeeks()
                
                if let firstDate = currentWeek.first?.date {
                    weekSlider.append(firstDate.createPreviousWeek())
                }
                
                weekSlider.append(currentWeek)
                
                if let nextDate = currentWeek.last?.date {
                    weekSlider.append(nextDate.createNextWeek())
                }
                
                state.header = .init(
                    today: .init(
                        week: state.currentDate.validateIsToday(),
                        weekCompleted: state.currentDate.week()
                    ),
                    slider: .init(.init(
                        currentDate: state.currentDate,
                        weekSlider: weekSlider
                    ))
                )
                
                state.taskCreate = nil
                
                return .run { send in
                    enum CancelID { case saveDebounce }
                    do {
                        try await withTaskCancellation(id: CancelID.saveDebounce, cancelInFlight: true) {
                            let tasks = try JSONDecoder().decode([Task.Model].self, from: loadData(.tasks))
                            await send(.loadedData(tasks), animation: .default)
                        }
                    } catch {
                        // TODO: FIX IT
                    }
                }
                
            case .loadedData(let loaded):
                state.tasks = loaded
                showTaskByDate(&state)
                return .none
                
            case .matcheAnimationRemoved:
                state.forcePadding = false
                state.contentTask = nil
                
                return .none
                
            case let .saveNewTask(tasks):
                return .run { send in
                    enum CancelID { case saveDebounce }
                    do {
                        try await withTaskCancellation(id: CancelID.saveDebounce, cancelInFlight: true) {
                            try self.saveData(
                                JSONEncoder().encode(tasks),
                                .tasks
                            )
                        }
                        
                        await send(.onAppear, animation: .snappy)
                    } catch {
                        dump("Erro for save data - \(error.localizedDescription)")
                    }
                }
                
            case let .task(.item(_, .leadingAction(id))):
                state.tasks.removeAll { $0.id == id }
                
                return .send(.saveNewTask(state.tasks))
                    
            case .task(.item(_, .trailingAction(_))):
                
                return .none
                
            default:
                return .none
            }
        }
        
        
        private func bottomSheet(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            case .bottomSheet(.addButtonTapped):
                guard state.header != nil else { return .none }
                state.header?.isScroll = false
                
                return .none
            default:
                return .none
            }
        }
        
        private func taskCreate(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
                
            case .task(.showTaskCreate):
                state.taskCreate = .init(date: state.currentDate)
                
                return .none
                
            case .taskCreate(.createTaskTapped):
                
                guard let content = state.taskCreate else { return .none }
                
                guard state.task != nil else { return .none }
                
                let componets = content.tag.value.components(separatedBy: ", ")
                let tags: [Tag.Model] = componets.map {
                    .init(value: $0)
                }
                
                guard state.task != nil else { return .none }
                guard let count = state.task?.item.count else { return .none }
                
                let createdTask: Task.Model = .init(title: content.title,
                                                    date: content.date,
                                                    startedHour: content.hour,
                                                    duration: Double(content.activityDuration.rawValue),
                                                    color: content.color,
                                                    isAlert: false,
                                                    isRepeted: false,
                                                    position: (count + 1),
                                                    createdAt: .now,
                                                    updatedAt: .now,
                                                    tag: tags,
                                                    note: .init(author: "", item: [])
                )
                
                state.tasks.append(createdTask)
                
                return .send(.saveNewTask(state.tasks))
                
            case .taskCreate(.closeTapped):
                return .send(.onAppear, animation: .snappy)
                
            default:
                return .none
            }
        }
        
        private func showTaskByDate(_ state: inout State) {
            let showingDate = state.currentDate
            
            let tasks = state.tasks.filter { task in
                task.date.compareDate(showingDate)
            }
            
            var identifiableTask: IdentifiedArrayOf<TaskItem.Feature.State> = []
            
            if !tasks.isEmpty {
                tasks.forEach { task in
                    identifiableTask.append(.init(task: task))
                }
            }
            
            state.task = .init(.init(
                item: tasks.isEmpty ? [] : identifiableTask,
                showCreateTask: state.currentDate.isToday() ? true : state.currentDate.isAfterByDate(.now) ? true : false
            ))
            
        }
    }
}
