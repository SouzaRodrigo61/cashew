//
//  HeaderSlider+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 21/09/23.
//

import SwiftUI
import ComposableArchitecture

extension HeaderSlider {
    struct View: SwiftUI.View {
        /// Animation Namespace
        @Namespace private var animation
        /// Store
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            WithViewStore(store, observe: { $0 }) { viewStore in
                TabView(selection: viewStore.$currentIndex) {
                    ForEach(viewStore.weekSlider.indices, id: \.self) { index in
                        let week = viewStore.weekSlider[index]
                        
                        WeekView(week, currentDate: viewStore.currentDate)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 50)
                .onAppear {
                    store.send(.onAppear, animation: .snappy)
                }
            }
        }
        
        @ViewBuilder
        private func WeekView(_ week: [Date.Week], currentDate: Date) -> some SwiftUI.View {
            HStack(alignment: .center, spacing: 0) {
                ForEach(week) { day in
                    VStack(spacing: 0) {
                        Text(day.date.format("E").capitalized)
                            .font(.system(.caption, design: .monospaced))
                            .fontWeight(day.date.isToday() ? .bold : .medium)
                            .textScale(.secondary)
                            .foregroundStyle(
                                isSameDate(day.date, currentDate)
                                ? .cute500 : day.date.isToday()
                                ? .royalBlue : day.date.isAfterByDate(.now)
                                ? .gunmetal : .grey500)
                        //                            .matchedGeometryEffect(id: "currentlyDate", in: animation)
                        
                        Spacer()
                        
                        Text(day.date.format("dd"))
                            .font(.title3)
                            .fontWeight(.bold)
                            .textScale(.secondary)
                            .foregroundStyle(
                                isSameDate(day.date, currentDate)
                                ? .cute500 : day.date.isToday()
                                ? .royalBlue : day.date.isAfterByDate(.now)
                                ? .gunmetal : .grey500)
                        //                            .matchedGeometryEffect(id: "currentlyDate", in: animation)
                            .padding(.bottom, isSameDate(day.date, currentDate) ? 0 : 2)
                        
                        
                        if isSameDate(day.date, currentDate) {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(.cute500)
                                .matchedGeometryEffect(id: "currentlyDate", in: animation)
                                .frame(height: 2)
                        }
                    }
                    .foregroundStyle(isSameDate(day.date, currentDate) ? .white : .gray)
                    .hSpacing(.center)
                    .onTapGesture {
                        store.send(.selectDate(day.date), animation: .snappy)
                    }
                }
            }
            .background {
                GeometryReader { geo in
                    let minX = geo.frame(in: .global).minX
                    
                    WithViewStore(store, observe: \.createWeek) { viewStore in
                        Color.clear
                            .preference(key: OffsetKey.self, value: minX)
                            .onPreferenceChange(OffsetKey.self) { value in
                                if (abs(value.rounded()) >= 15 && abs(value.rounded()) <= 20) && viewStore.state {
                                    store.send(.paginateWeek)
                                }
                            }
                    }
                }
            }
        }
    }
}
