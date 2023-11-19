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
                .frame(height: 60)
                .onAppear {
                    store.send(.onAppear, animation: .snappy)
                }
            }
        }
        
        @ViewBuilder
        private func WeekView(_ week: [Date.Week], currentDate: Date) -> some SwiftUI.View {
            HStack(alignment: .bottom, spacing: 0) {
                ForEach(week) { day in
                    VStack(spacing: 0) {
                        Text(day.date.format("E").capitalized)
                            .font(.caption)
                            .fontWeight(day.date.isToday() ? .bold : .medium)
                            .textScale(.secondary)
                            .foregroundStyle(
                                isSameDate(day.date, currentDate)
                                ? .white : day.date.isToday()
                                ? .royalBlue : day.date.isAfterByDate(.now)
                                ? .gunmetal : .grey500)
                            .padding(.bottom, 8)
                        Text(day.date.format("dd"))
                            .font(.body)
                            .fontWeight(.bold)
                            .textScale(.secondary)
                            .foregroundStyle(
                                isSameDate(day.date, currentDate)
                                ? .white : day.date.isToday()
                                ? .royalBlue : day.date.isAfterByDate(.now)
                                ? .gunmetal : .grey500)
                    }
                    .padding(.vertical, 4)
                    .foregroundStyle(isSameDate(day.date, currentDate) ? .white : .gray)
                    .hSpacing(.center)
                    .background {
                        if isSameDate(day.date, currentDate) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.royalBlue)
                                .matchedGeometryEffect(id: "currentlyDate", in: animation)
                        }
                    }
                    .onTapGesture {
                        store.send(.selectDate(day.date), animation: .smooth)
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
