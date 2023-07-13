//
//  TaskView.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 08/07/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TaskManagementView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.miamiLightGray)
    }
}

struct TaskManagementView: View {
    
    /// Task Manager Properties
    @State private var currentDate: Date = .init()
    @State private var weekSlider: [[Date.WeekDay]] = []
    @State private var currentWeekIndex: Int = 1
    @State private var createWeek: Bool = false
    @State private var tasks: [TaskManagementModel] = sampleTasks.sorted { $1.createdAt > $0.createdAt
    }
    
    /// Animated
    @Namespace private var SelectedDate
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HeaderView()
            
            ScrollView(.vertical) {
                VStack {
                    TasksView()
                }
                .hSpacing(.center)
                .vSpacing(.center)
            }
            .scrollIndicators(.hidden)
        }
        .vSpacing(.top)
        .onAppear {
            if weekSlider.isEmpty {
                let currentWeek = Date().fetchWeek()
                
                if let firstDate = currentWeek.first?.date {
                    weekSlider.append(firstDate.createPreviousWeek())
                }
                
                weekSlider.append(currentWeek)
                
                if let lastDate = currentWeek.last?.date {
                    weekSlider.append(lastDate.createNextWeek())
                }
            }
        }
    }
    
    /// Header View
    @ViewBuilder
    func HeaderView() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(currentDate.format("MMMM").capitalized)
                    .foregroundStyle(.miamiDarkBlue)
                Text(currentDate.format("YYYY").capitalized)
                    .foregroundStyle(.miamiGray)
            }
            .font(.title.bold())
            
            Text(currentDate.formatted(date: .complete, time: .omitted).capitalized)
                .font(.callout)
                .fontWeight(.semibold)
                .textScale(.secondary)
                .foregroundStyle(.miamiGray)
            
            /// Week Slider
            TabView(selection: $currentWeekIndex) {
                ForEach(weekSlider.indices, id: \.self) { index in
                    let week = weekSlider[index]
                    WeekView(week)
                        .padding(.horizontal, 15)
                        .tag(index)
                }
            }
            .padding(.horizontal, -15)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 90)
        }
        .hSpacing(.leading)
        .overlay(alignment: .topTrailing) {
            Button(action: {}, label: {
                Image(.user1)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(.circle)
            })
            .padding(2)
            .background(.miamiWhite.shadow(.drop(radius: 1)), in: .circle)
        }
        .padding(15)
        .background(.miamiWhite)
        .onChange(of: currentWeekIndex, initial: false) { oldValue, newValue in
            /// Creating When it reaches first/last Page
            if newValue == 0 || newValue == (weekSlider.count - 1) {
                createWeek = true
            }
        }
    }
    
    /// Week View
    @ViewBuilder
    func WeekView(_ week: [Date.WeekDay]) -> some View {
        HStack(spacing: 0) {
            ForEach(week) { day in
                VStack(spacing: 8) {
                    Text(day.date.format("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(.miamiGray)
                    
                    Text(day.date.format("dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary)
                        .foregroundStyle(isSameDate(day.date, currentDate) ? .miamiWhite : .miamiDarkGrayOne)
                        .frame(width: 35, height: 35)
                        .background {
                            if isSameDate(day.date, currentDate) {
                                Circle()
                                    .fill(.miamiDarkBlue)
                                    .matchedGeometryEffect(id: "TABINDICATOR", in: SelectedDate)
                            }
                            
                            if day.date.isToday {
                                Circle()
                                    .fill(.miamiDarkPurple)
                                    .frame(width: 5, height: 5)
                                    .vSpacing(.bottom)
                                    .offset(y: 12)
                            }
                        }
                        .background(.miamiWhite.shadow(.drop(radius: 1)), in: .circle)
                }
                .hSpacing(.center)
                .contentShape(.rect)
                .onTapGesture {
                    /// Updating Current Date
                    withAnimation(.snappy) {
                        currentDate = day.date
                    }
                }
            }
        }
        .background {
            GeometryReader { geo in
                let minX = geo.frame(in: .global).minX
                
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self) { value in
                        /// When the Offset reaches 15 and if the createWeek is toggle then simply generating next set of week
                        if value.rounded() == 15 && createWeek {
                            paginateWeek()
                            createWeek = false
                        }
                    }
            }
        }
    }
    
    /// Tasks View
    @ViewBuilder
    func TasksView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach($tasks) { $task in
                TaskRowView(task: $task)
                    .background(alignment: .leading) {
                        if tasks.last?.id != task.id {
                            Rectangle()
                                .fill(.miamiDarkGrayOne)
                                .frame(width: 2)
                                .offset(x: 8)
                                .padding(.bottom, -28)
                        }
                    }
            }
        }
        .padding([.vertical, .leading], 15)
        .padding(.top, 40)
    }
    
    // MARK: - View Actions
    func paginateWeek() {
        /// Safe Check
        if weekSlider.indices.contains(currentWeekIndex) {
            if let firstDate = weekSlider[currentWeekIndex].first?.date, currentWeekIndex == 0 {
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
            }
            
            if let lastDate = weekSlider[currentWeekIndex].last?.date, currentWeekIndex == (weekSlider.count - 1)  {
                weekSlider.append(lastDate.createNextWeek())
                weekSlider.removeFirst()
                currentWeekIndex = (weekSlider.count - 2)
            }
        }
    }
}

#Preview {
    ContentView()
}

