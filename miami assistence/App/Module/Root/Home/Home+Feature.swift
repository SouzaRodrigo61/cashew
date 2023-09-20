//
//  Home+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import SwiftUI
import ComposableArchitecture

extension Home {
    struct Feature: Reducer {
        struct State: Equatable {
            var taskCalendar: TaskCalendar.Feature.State
            var bottomSheet: BottomSheet.Feature.State?
            var taskCreate: TaskCreate.Feature.State?
            
            var destination: StackState<Destination.State>
            @PresentationState var schedule: Schedule.Feature.State?
            
            var contentTask: Task.Model?
            var tasks: [Task.Model] = []
            
            /// Custom Matched Geometry Animation
            var forcePadding: Bool = false
            var currentIndex: Int = 1
            
            init(taskCalendar: TaskCalendar.Feature.State, destination: StackState<Destination.State>, bottomSheet: BottomSheet.Feature.State? = nil) {
                self.taskCalendar = taskCalendar
                self.destination = destination
                self.bottomSheet = bottomSheet
            }
            
        }
        
        enum Action: Equatable {
            
            /// Components Stores
            case bottomSheet(BottomSheet.Feature.Action)
            case taskCreate(TaskCreate.Feature.Action)
            case taskCalendar(TaskCalendar.Feature.Action)
            
            /// Local Actions
            case matcheAnimationRemoved
            
            case showTaskByDate
            
            /// Navigation Stores
            case destination(StackAction<Destination.State, Destination.Action>)
            case schedule(PresentationAction<Schedule.Feature.Action>)
            
            case onAppear
            case loadedData([Task.Model])
        }
        
        
        @Dependency(\.storeManager.save) var saveData
        @Dependency(\.storeManager.load) var loadData
        
        var body: some Reducer<State, Action> {
            Reduce(self.core)
                .ifLet(\.bottomSheet, action: /Action.bottomSheet) {
                    BottomSheet.Feature()
                }
                .ifLet(\.taskCreate, action: /Action.taskCreate) {
                    TaskCreate.Feature()
                }
                .ifLet(\.$schedule, action: /Action.schedule) {
                    Schedule.Feature()
                }
                .forEach(\.destination, action: /Action.destination) {
                    Destination()
                }
        }
        
        private func core(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
                
                // MARK: - Home Basic Action
                
            case .onAppear:
                return .run { send in
                    let tasks = try JSONDecoder().decode([Task.Model].self, from: loadData(.tasks))
                    await send(.loadedData(tasks), animation: .default)
                }
                
            case .loadedData(let loaded):
                state.tasks = loaded
                showTaskByDate(&state)
                return .none
                
            case .matcheAnimationRemoved:
                state.forcePadding = false
                state.contentTask = nil
                
                return .none
                
            case .showTaskByDate:
                showTaskByDate(&state)
                
                return .none
                
            case .bottomSheet(.addButtonTapped):
                let date = state.taskCalendar.weekSlider[state.taskCalendar.currentIndex]
                state.taskCreate = .init(date: date.date)
                
                state.bottomSheet?.collapse = false
                
                guard state.taskCalendar.header != nil else { return .none }
                state.taskCalendar.header?.isScroll = false
                
                return .none
                
            case .destination(.element(id: _, action: .note(.closeTapped))):
                state.forcePadding = true
                return .run { send in
                    try! await SwiftUI.Task.sleep(for: .seconds(0.04))
                    await send(.matcheAnimationRemoved, animation: .smooth)
                }
                
                
                // MARK:  TaskCalendar and Childs Actions
                
            case .taskCalendar(.task(.showTaskCreate)):
                let date = state.taskCalendar.weekSlider[state.taskCalendar.currentIndex]
                state.taskCreate = .init(date: date.date)
                
                state.bottomSheet?.collapse = false
                
                guard state.taskCalendar.header != nil else { return .none }
                state.taskCalendar.header?.isScroll = false
                
                return .none
                
            case let .taskCalendar(.task(.item(_, .contentTapped(task)))):
                state.destination.append(.note(.init(task: task)))
                state.contentTask = task
                
                return .none
                
            case .taskCalendar(.header(.today(.buttonTapped))):
                state.schedule = .init()
                
                return .none
                
            case let .taskCalendar(.previousDay(day)):
                
                state.taskCalendar.weekSlider.insert(day.createPreviousDay(), at: 0)
                state.taskCalendar.weekSlider.removeLast()
                
                state.taskCalendar.currentIndex = 1
                state.taskCalendar.createDay = false
                
                return .none
                
            case let .taskCalendar(.nextDay(day)):
                
                state.taskCalendar.weekSlider.append(day.createNextDay())
                state.taskCalendar.weekSlider.removeFirst()
                
                state.taskCalendar.currentIndex = 1
                state.taskCalendar.createDay = false
                
                return .none
                
            case let .taskCalendar(.tabSelected(index)):
                state.taskCalendar.currentIndex = index
                if index == 0 || index == (state.taskCalendar.weekSlider.count - 1) {
                    state.taskCalendar.createDay = true
                }
                
                let currentDate = state.taskCalendar.weekSlider[index].date
                
                state.taskCalendar.currentDate = currentDate
                state.taskCalendar.task = .init(empty: .init(.init(currentDate: currentDate)))
                state.taskCalendar.header = .init(
                    today: .init(
                        week: currentDate.validateIsToday(),
                        weekCompleted: currentDate.week()
                    )
                )
                
                return .run { @MainActor send in
                    send(.showTaskByDate, animation: .snappy)
                }
                
            case .taskCalendar(.header(.searchTapped)):
                state.destination.append(.search(.init()))
                return .none
                
            case .taskCalendar(.header(.moreTapped)):
                state.destination.append(.settings(.init()))
                return .none
                
            case let .taskCalendar(.task(.item(id, .leadingAction(taskId)))):
                dump("leadingAction: \(id) -> \(taskId)")
                return .none
                
            case let .taskCalendar(.task(.item(id, .trailingAction(taskId)))):
                dump("trailingAction: \(id) -> \(taskId)")
                return .none
                
                // MARK: - Task Create Actions
                
            case .taskCreate(.createTaskTapped):
                guard let content = state.taskCreate else { return .none }
                
                guard state.taskCalendar.task != nil else { return .none }
                guard let count = state.taskCalendar.task?.item.count else { return .none }
                state.taskCalendar.task?.empty = nil
                
                let componets = content.tag.value.components(separatedBy: ", ")
                let tags: [Tag.Model] = componets.map {
                    .init(value: $0)
                }
                
                // TODO: StartedHour show correct hour
                state.tasks.append(.init(title: content.title, date: content.date, startedHour: .now, duration: Double(content.activityDuration.rawValue), color: content.color, isAlert: false, isRepeted: false, position: (count + 1), createdAt: .now, updatedAt: .now, tag: tags, note: []))
                
                state.taskCreate = nil
                
                return .run { [task = state.tasks] send in
                    
                    enum CancelID { case saveDebounce }
                    try await withTaskCancellation(id: CancelID.saveDebounce, cancelInFlight: true) {
                        try self.saveData(
                            JSONEncoder().encode(task),
                            .tasks
                        )
                    }
                    
                    await send(.showTaskByDate, animation: .snappy)
                }
                
            case .taskCreate(.closeTapped):
                state.taskCreate = nil
                
                guard state.taskCalendar.header != nil else { return .none }
                state.taskCalendar.header?.isScroll = false
                
                return .none
                
            default:
                return .none
            }
        }
        
        private func showTaskByDate(_ state: inout State) {
            let showingDate = state.taskCalendar.currentDate
            
            let tasks = state.tasks.filter { task in
                task.date.compareDate(showingDate)
            }
            
            var identifiableTask: IdentifiedArrayOf<TaskItem.Feature.State> = []
            
            if !tasks.isEmpty {
                tasks.forEach { task in
                    identifiableTask.append(.init(task: task))
                }
            }
            
            state.taskCalendar.task = .init(.init(
                item: tasks.isEmpty ? [] : identifiableTask,
                empty: tasks.isEmpty ? .init(currentDate: showingDate) : nil
            ))

        }
    }
}



extension URL {
    static let tasks = Self.documentsDirectory.appending(component: "tasks.json")
}
