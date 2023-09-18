//
//  Create+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 19/08/23.
//


import ComposableArchitecture
import SwiftUI

extension TaskCreate {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        @FocusState private var focusedField: Field?
        @State var username: String = ""
        
        @State var color = Color.blue
        @State var selectedDate = Date()
        
        let dateRange: ClosedRange<Date> = {
            let calendar = Calendar.current
            let startComponents = DateComponents(year: Date().getYear(), month: Date().getMonth(), day: Date().getDay())
            let endComponents = DateComponents(year: Date().getYear(), month: Date().getMonth() + 2, day: 31, hour: 23, minute: 59, second: 59)
            return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
        }()
        
        var body: some SwiftUI.View {
            WithViewStore(store, observe: { $0 } ) { viewStore in
                VStack {
                    HStack {
                        Text("task.create.nav.title")
                            .font(.system(.title3, design: .rounded, weight: .bold))
                        
                        Spacer()
                        
                        Button {
                            store.send(.closeTapped, animation: .bouncy)
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundStyle(.gray)
                        }
                        .buttonStyle(.pressBordered)
                    }
                    .padding(.horizontal, 16)
                    
                    Form {
                        Section {
                            TextField("task.create.textfield.placeholder", text: viewStore.$title)
                                .font(.system(.title2, design: .rounded, weight: .bold))
                                .padding(.horizontal, 16)
                        }
                        .listRowInsets(.init())
                        .listRowBackground(Color.lotion)
                        
                        Section {
                            ColorPicker("task.create.picker.color", selection: viewStore.$color, supportsOpacity: false)
                                .font(.system(.headline, design: .rounded, weight: .semibold))
                                .padding(.horizontal, 16)
                        }
                        .listRowInsets(.init())
                        .listRowBackground(Color.lotion)
                        
                        Section {
                            DatePicker("task.create.picker.date",
                                       selection: viewStore.$date,
                                       in: dateRange,
                                       displayedComponents: [.date])
                            .padding(.horizontal, 16)
                            .datePickerStyle(.graphical)
                            
                            .environment(\.locale, Locale.current)
                            .environment(\.calendar, Locale.current.calendar)
                            .environment(\.timeZone, TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "")!)
                            
                            DatePicker("task.create.picker.date",
                                       selection: viewStore.$startedHour,
                                       in: dateRange,
                                       displayedComponents: [.hourAndMinute])
                            .padding(.horizontal, 16)
                            .datePickerStyle(.graphical)
                            
                            .environment(\.locale, Locale.current)
                            .environment(\.calendar, Locale.current.calendar)
                            .environment(\.timeZone, TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "")!)
                        }
                        .listRowInsets(.init())
                        .listRowBackground(Color.lotion)
                    }
                    .listSectionSpacing(8)
                    .coordinateSpace(name: "SCROLL")
                    .accessibilityLabel("Lista de dados")
                    .contentMargins(8, for: .scrollContent)
                    .listRowSpacing(8)
                    .scrollIndicators(.hidden)
                    .environment(\.defaultMinListRowHeight, 64)
                    .scrollContentBackground(.hidden)
                    .scrollDismissesKeyboard(.interactively)
                    
                    Button {
                        store.send(.createTaskTapped, animation: .smooth)
                    } label: {
                        Text("task.create.button.title")
                            .foregroundStyle(.white)
                            .padding(16)
                            .hSpacing(.center)
                            .background(.dark, in: .rect(cornerRadius: 10))
                    }
                    .buttonStyle(.scale)
                    .padding(.horizontal, 16)
                }
            }
        }
    }
}

extension TaskCreate.View {
    private enum Field: Int, Hashable {
        case name
    }
}
