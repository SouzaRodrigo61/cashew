//
//  ScheduleView.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 02/07/23.
//

import SwiftUI

struct ScheduleView: View {
    @Namespace private var animatedSchedule
    @State private var scrollPosition: CGFloat = 0
    
    
    let scheduleViewModel: ScheduleViewModel
    
    init(viewModel: ScheduleViewModel = ScheduleViewModel()) {
        self.scheduleViewModel = viewModel
    }
    
    var drag: some Gesture {
      DragGesture()
        .onEnded { state in
            if state.translation.width < 0 {
                withAnimation {
                    scheduleViewModel.currentWeekOffset += 1
                }
            }
            
            if state.translation.width > 0 {
                withAnimation {
                    scheduleViewModel.currentWeekOffset -= 1
                }
            }
        }
    }
    
    var body: some View {
        ScrollView(.vertical) {
            
            // MARK: Lazy Stack With Pinned Header
            LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                Section {
                    
                    WeekView()
                    
                    Text("\(scheduleViewModel.getCurrentWeek())")
                    
//                    DaysView()
                    AppointmentView()
                    
                } header: {
                    HeaderView()
                }
                
            }
        }
        .scrollIndicators(.never)
        .ignoresSafeArea(.container, edges: .top)
        .preferredColorScheme(.light)
    }
    
    
    // MARK: - Header View
    @ViewBuilder
    func HeaderView() -> some View {
        HStack(spacing: 10) {
            Button {
               scheduleViewModel.currentWeekOffset = 0
            } label: {
                VStack(alignment: .leading, spacing: 6) {
                    Text(Date().formatted(date: .abbreviated, time: .omitted))
                        .foregroundStyle(.miamiGray)
                    
                    Text("Today")
                        .font(.largeTitle.bold())
                }
            }
            .hLeading()
            
            Button {
                
            } label: {
                Image(systemName: "person")
                    .frame(width: 45, height: 45)
                    .background(.miamiLightGray)
                    .clipShape(Circle())
            }
        }
        .padding()
        .padding(.top, getSafeArea().top)
        .background(.miamiWhite)
    }
    
    
    // MARK: - Week View
    @ViewBuilder
    func WeekView() -> some View {
        VStack {
            HStack(spacing: 10) {
                ForEach(scheduleViewModel.currentWeek, id: \.self) { day in
                    VStack {
                        Text(scheduleViewModel.extractDate(date: day, format: "dd"))
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text(scheduleViewModel.extractDate(date: day, format: "EEE"))
                            .font(.body)
                        
                        Circle()
                            .fill()
                            .frame(width: 8, height: 8)
                            .opacity(scheduleViewModel.isToday(date: day) ? 1 : 0)
                    }
                    .id(day)
                    // MARK: Foreground Style
                    .padding(.vertical, 12)
                    .foregroundStyle(
                        scheduleViewModel.isToday(date: day) ? .miamiWhite : .miamiGray
                    )
                    // MARK: Capsule Shape
                    .frame(width: 45)
                    .background {
                        if scheduleViewModel.isToday(date: day) {
                            
                            // MARK: Matched Geometry Effect
                            Capsule()
                                .fill()
                                .foregroundStyle(.miamiBlack)
                                .matchedGeometryEffect(id: "CURRENTDAY", in: animatedSchedule)
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        let impactHeavy = UIImpactFeedbackGenerator(style: .soft)
                        impactHeavy.impactOccurred()
                        
                        // MARK: Update Current Day
                        withAnimation {
                            scheduleViewModel.currentDay = day
                            scheduleViewModel.fetchCurrentWeek()
                        }
                    }
                }
            }
        }
        .gesture(drag)
        .onChange(of: scheduleViewModel.currentWeekOffset, { _, _ in
            scheduleViewModel.fetchCurrentWeek()
        })
        .padding(.horizontal)
        
    }
    
    // MARK: - Days View
    @ViewBuilder
    func DaysView() -> some View {
        ScrollView(.horizontal) {
            ScrollViewReader { proxy in
                HStack(spacing: 10) {
                    ForEach(scheduleViewModel.currentWeek, id: \.self) { day in
                        VStack {
                            Text(scheduleViewModel.extractDate(date: day, format: "dd"))
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Text(scheduleViewModel.extractDate(date: day, format: "EEE"))
                                .font(.body)
                            
                            Circle()
                                .fill()
                                .frame(width: 8, height: 8)
                                .opacity(scheduleViewModel.isToday(date: day) ? 1 : 0)
                        }
                        .id(day)
                        // MARK: Foreground Style
                        .padding(.vertical, 12)
                        .foregroundStyle(
                            scheduleViewModel.isToday(date: day) ? .miamiWhite : .miamiGray
                        )
                        // MARK: Capsule Shape
                        .frame(width: 45)
                        .background {
                            if scheduleViewModel.isToday(date: day) {
                                
                                // MARK: Matched Geometry Effect
                                Capsule()
                                    .fill()
                                    .foregroundStyle(.miamiBlack)
                                    .matchedGeometryEffect(id: "CURRENTDAY", in: animatedSchedule)
                            }
                        }
                        .contentShape(Capsule())
                        .onTapGesture {
                            let impactHeavy = UIImpactFeedbackGenerator(style: .soft)
                            impactHeavy.impactOccurred()
                            
                            // MARK: Update Current Day
                            withAnimation {
                                scheduleViewModel.currentDay = day
                                proxy.scrollTo(day, anchor: .center)
                            }
                        }
                        .onAppear {
                            let scrollTo = scheduleViewModel.currentWeek.first {
                                scheduleViewModel.isToday(date: $0)
                            }
                            
                            withAnimation {
                                
                                proxy.scrollTo(scrollTo, anchor: .center)
                            }
                        }
                        
                    }
                    
                }
                .padding(.horizontal)
            }
        }
        .coordinateSpace(name: "HORIZONTALSCROLLING")
        .scrollIndicators(.never)
    }
    
    // MARK: - Appointment View
    @ViewBuilder
    func AppointmentView() -> some View {
        LazyVStack(spacing: 25) {
            if let schedules = scheduleViewModel.filteredSchedule {
                if schedules.isEmpty {
                    Text("No task found!!!")
                        .font(.title3)
                        .fontWeight(.light)
                        .offset(y: 100)
                } else {
                    ForEach(schedules, id: \.title) { schedule in
                        ScheduleCardView( schedule)
                    }
                }
            } else {
                ProgressView()
                    .offset(y: 100)
            }
        }
        .padding()
        .padding(.top)
        // MARK: Update schedule
        .onChange(of: scheduleViewModel.currentDay) { _, newValue in
            scheduleViewModel.filterTodayAppointment()
        }
    }
    
    // MARK: Schedule Card View
    @ViewBuilder
    func ScheduleCardView(_ schedule: Schedule) -> some View {
        HStack(alignment: .top, spacing: 30) {
            VStack {
                Circle()
                    .foregroundStyle(scheduleViewModel.isCurrentHour(date: schedule.date) ? .miamiBlack : .clear)
                    .frame(width: 15, height: 15)
                    .background {
                        Circle()
                            .stroke(.miamiBlack, lineWidth: 1)
                            .padding(-3)
                    }
                    .scaleEffect(!scheduleViewModel.isCurrentHour(date: schedule.date) ? 0.8 : 1)
                
                Rectangle()
                    .foregroundStyle(.miamiBlack)
                    .frame(width: 3)
            }
            
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 12 ) {
                        Text(schedule.title)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(schedule.description)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    .hLeading()
                    
                    Text(schedule.date.formatted(date: .omitted, time: .shortened))
                }
                
                if scheduleViewModel.isCurrentHour(date: schedule.date) {
                    // MARK: Team Members
                    HStack(spacing: 0) {
                        HStack(spacing: -10) {
                            ForEach(["User1", "User2", "User3"], id: \.self) { user in
                                Image(user)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 45, height: 45)
                                    .clipShape(Circle())
                                    .background {
                                        Circle()
                                            .stroke(.miamiBlack, lineWidth: 5)
                                    }
                            }
                        }
                        .hLeading()
                        
                        // MARK: Check Button
                        Button {
                            
                        } label: {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.miamiBlack)
                                .padding(10)
                                .background(.miamiWhite, in: RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .padding(.top)
                }
            }
            .foregroundStyle(scheduleViewModel.isCurrentHour(date: schedule.date) ? .miamiWhite : .miamiBlack)
            .padding(scheduleViewModel.isCurrentHour(date: schedule.date) ? 15 : 0)
            .padding(.bottom, scheduleViewModel.isCurrentHour(date: schedule.date) ? 0 : 10)
            .hLeading()
            .background {
                Color.miamiDarkGraySecond
                    .cornerRadius(25, corners: .allCorners)
                    .opacity(scheduleViewModel.isCurrentHour(date: schedule.date) ? 1 : 0)
            }
        }
        .hLeading()
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static var lastHorizontalOffset: CGFloat = 0.0
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        let newValue = nextValue()
        
        if newValue.x != value.x {
            if newValue.x > value.x {
                // Deslocamento para a direita
                print("Deslocamento para a direita")
            } else {
                // Deslocamento para a esquerda
                print("Deslocamento para a esquerda")
            }
        }
    }
}
