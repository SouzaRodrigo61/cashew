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
        @State var username: String = ""
        
        @State var color = Color.blue
        @State var selectedDate = Date()
        
        @FocusState var focus: Feature.State.Field?
        
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
                        HStack(alignment: .bottom) {
                            
                            Text("task.create.nav.title")
                                .font(.system(.title2, design: .rounded, weight: .bold))
                            
                            Text(viewStore.date.week())
                                .font(.system(.body, design: .rounded, weight: .medium))
                                .foregroundStyle(.gray)
                        }
                        
                        Spacer()
                        
                        Button {
                            store.send(.closeTapped, animation: .bouncy)
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
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
                            VStack(alignment: .leading, spacing: 0) {
                                Text("task.create.tag")
                                    .font(.system(.headline, design: .rounded, weight: .bold))
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 4)
                                
                                TextField("task.create.tag.placeholder", text: viewStore.$tag.value)
                                    .font(.system(.body, design: .rounded, weight: .bold))
                                    .focused(self.$focus, equals: Feature.State.Field.tag(viewStore.tag.id))
                                    .foregroundStyle(.gray)
                                    .padding(.horizontal, 16)
                                
                            }
                            .padding(.vertical, 8)
                        }
                        .listRowInsets(.init())
                        .listRowBackground(Color.lotion)
                        
                        Section {
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Text("task.create.picker.datetime.title")
                                    .font(.system(.headline, design: .rounded, weight: .bold))
                                    .padding(.horizontal, 16)
                                    .padding(.top, 8)
                                
                                Picker(selection: viewStore.$startedHour, label: Text("")) {
                                    ForEach(0..<viewStore.hours.count, id: \.self) { index in
                                        Text("\(viewStore.hours[index])")
                                            .tag(index)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .overlay(alignment: .center) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .frame(height: 40)
                                        .foregroundStyle(.lotion)
                                        .overlay {
                                            Button {
//                                                store.send(.hourTapped)
                                            } label: {
                                                Text(viewStore.selectedHour)
                                                    .font(.system(.headline, design: .rounded, weight: .bold))
                                                    .getContrastText(backgroundColor: viewStore.color)
                                                    .padding(.horizontal, 40)
                                                    .padding(.vertical, 10)
                                                    .background(viewStore.color, in: .rect(cornerRadius: 10))
                                            }
                                            .buttonStyle(.scale)
                                        }
                                }
                                
                                
                                Picker("", selection: viewStore.$activityDuration) {
                                    ForEach(Feature.State.ActivityDuration.allCases, id: \.self) { option in
                                        if option.rawValue >= 60 {
                                            Text("\(option.rawValue == 60 ? "1h" : "1:30h")")
                                                .tag(option)
                                        } else {
                                            Text("\(option.rawValue) min")
                                                .tag(option)
                                        }
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .padding(.horizontal, 16)
                                .padding(.bottom, 8)
                            }
                        }
                        .listRowInsets(.init())
                        .listRowBackground(Color.lotion)
                        
                        Section {
                            ColorPicker("task.create.picker.color", selection: viewStore.$color, supportsOpacity: false)
                                .font(.system(.body, design: .rounded, weight: .bold))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                        }
                        .listRowInsets(.init())
                        .listRowBackground(Color.lotion)
                        
                        Button {
                            store.send(.createTaskTapped, animation: .smooth)
                        } label: {
                            Text("task.create.button.title")
                                .font(.system(.headline, design: .rounded, weight: .bold))
                                .getContrastText(backgroundColor: viewStore.color)
                                .padding(.vertical, 16)
                                
                                .hSpacing(.center)
                                .background(viewStore.color, in: .rect(cornerRadius: 10))
                        }
//                        .listRowInsets(.init())
                        .buttonStyle(.scale)
                        .padding(.bottom, 6)
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
                    .scrollDismissesKeyboard(.immediately)
                    
                }
                .onAppear {
                    store.send(.onAppearSelectedHour, animation: .bouncy)
                }
            }
        }
    }
}
