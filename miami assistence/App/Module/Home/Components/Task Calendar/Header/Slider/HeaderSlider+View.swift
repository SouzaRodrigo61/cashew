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
                .frame(height: 80)
                .onAppear {
                    store.send(.onAppear, animation: .snappy)
                }
            }
        }
        
        @ViewBuilder
        private func WeekView(_ week: [Date.Week], currentDate: Date) -> some SwiftUI.View {
            HStack(alignment: .bottom, spacing: 0) {
                ForEach(week) { day in
                    VStack(spacing: 8) {
                        Text(day.date.format("E"))
                            .font(.callout)
                            .fontWeight(day.date.isToday() ? .bold : .medium)
                            .textScale(.secondary)
                            .foregroundStyle(day.date.isToday() ? .royalBlue : .gunmetal)
                        Text(day.date.format("dd"))
                            .font(.callout)
                            .fontWeight(.bold)
                            .textScale(.secondary)
                            .foregroundStyle(
                                isSameDate(day.date, currentDate)
                                ? .white : day.date.isToday()
                                ? .royalBlue : day.date.isAfterByDate(.now)
                                ? .gunmetal : .gray)
                            .frame(width: 35, height: 35)
                            .background {
                                if isSameDate(day.date, currentDate) {
                                    Circle()
                                        .fill(.blue)
                                        .matchedGeometryEffect(id: "currentlyDate", in: animation)
                                }
                            }
                    }
                    .foregroundStyle(isSameDate(day.date, currentDate) ? .white : .gray)
                    .hSpacing(.center)
                    .contentShape(.rect)
                    .onTapGesture {
                        store.send(.selectDate(day.date), animation: .snappy)
                    }
                }
            }
            .padding(.bottom, 8)
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
