//
//  TabCalendar+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 14/09/23.
//

import Foundation
import ComposableArchitecture

extension TaskCalendar {
    
    @Reducer
    struct Feature {
        
        @ObservableState
        struct State: Equatable {
            
            var bottomSheet: BottomSheet.Feature.State?
            var taskCreate: TaskCreate.Feature.State?
            
            var task: Task.Feature.State?
            var header: Header.Feature.State?
            
            var info: TaskInfo.Feature.State?
            var inspiration: TaskInspiration.Feature.State?
            
            var tasks: [Task.Model] = []
            
            var contentTask: Task.Model?
            
            /// Custom Matched Geometry Animation
            var forcePadding: Bool = false
            var currentDate: Date = .now
        }
        
        @CasePathable
        enum Action: Equatable {
            case matcheAnimationRemoved
            case onAppear
            case loadedData([Task.Model])
            case saveNewTask([Task.Model])
            case createTask(Task.Model)
            
            case task(Task.Feature.Action)
            case header(Header.Feature.Action)
            case bottomSheet(BottomSheet.Feature.Action)
            case taskCreate(TaskCreate.Feature.Action)
            case info(TaskInfo.Feature.Action)
            case inspiration(TaskInspiration.Feature.Action)
            
            case taskResponse(TaskResult<[Task.Model]>)
            
            case showTaskCreate
        }
        
        @Dependency(\.modelTask.fetch) var loadData
        @Dependency(\.modelTask.add) var saveData
        @Dependency(\.modelTask.delete) var deleteData
        
        var body: some Reducer<State, Action> {
            Reduce(self.bottomSheet)
            Reduce(self.taskCreate)
            Reduce(self.taskCalendar)
            Reduce(self.managerData)
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
                .ifLet(\.info, action: /Action.info) {
                    TaskInfo.Feature()
                }
                .ifLet(\.inspiration, action: /Action.inspiration) {
                    TaskInspiration.Feature()
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
                    )),
                    button: .init(),
                    goal: state.currentDate.isToday() ? .init() : nil,
                    currentDate: state.currentDate
                )
                
                state.taskCreate = nil
                
                return .run { send in
                    let data = try loadData()
                    await send(.taskResponse(.success(data)), animation: .default)
                } catch: { error, send in
                    await send(.taskResponse(.failure(error)), animation: .default)
                }
                
            case .taskResponse(.success(let tasks)):
                return .run { @MainActor send in
                    send(.loadedData(tasks))
                }
            case .taskResponse(.failure(let error)):
                dump(error, name: "taskResponse - error")
                
                return .none
                
                
            case .header(.slider(.selectDate(let date))):
                guard state.header?.today != nil else { return .none }
                
                state.header?.today?.week = date.validateIsToday()
                state.header?.today?.weekCompleted = date.week()
                
                state.currentDate = date
                state.header?.currentDate = date
                state.header?.goal = date.isToday() ? .init() : nil
                
                showTaskByDate(&state)
                return .none
                
            case .matcheAnimationRemoved:
                state.forcePadding = false
                state.contentTask = nil
                
                return .none
                
            case .showTaskCreate:
                state.taskCreate = .init(date: state.currentDate)
                
                return .none

            case .task(.isEmpty(.buttonTapped)):
                state.taskCreate = .init(date: state.currentDate)
                
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
                
            case .taskCreate(.createTaskTapped):
                
                guard let content = state.taskCreate else { return .none }
                
                guard state.task != nil else { return .none }
                
                let componets = content.tag.value.components(separatedBy: ", ")
                let _: [Tag.Model] = componets.map {
                    .init(value: $0)
                }
                
                guard state.task != nil else { return .none }

                let createdTask: Task.Model = .init(title: content.title, date: content.date, startedHour: content.hour, duration: Double(content.activityDuration.rawValue), isAlert: false, isRepeted: false, createdAt: .now, updatedAt: .now, color: content.color.toHex())
                
                return .send(.createTask(createdTask))
                
            case .taskCreate(.closeTapped):
                return .send(.onAppear, animation: .snappy)
                
            default:
                return .none
            }
        }
        
        private func managerData(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            
            case let .task(.item(.element(id: _, action: .deleteTask(task)))):
                return .run { send in
                    try deleteData(task)
                    await send(.onAppear)
                } catch: { error, send in
                    dump("Erro for delete data - \(error.localizedDescription)")
                }
                
            case let .createTask(task):
                state.taskCreate = nil
                return .run { send in
                    try saveData(task)
                    await send(.onAppear)
                } catch: { error, send in
                    dump("Erro for save data - \(error.localizedDescription)")
                }
                
            case .loadedData(let loaded):
                state.tasks = loaded
                showTaskByDate(&state)
                return .none
                
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
                item: identifiableTask,
                isEmpty: tasks.isEmpty ? .init(currentDate: state.currentDate) : nil
            ))
            
        }
    }
}


