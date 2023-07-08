//
//  DatePickerView.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 05/07/23.
//

import SwiftUI

struct DatePickerView: View {
    @State var currentDate: Date
    
    @State var currentMonth: Int = 0
    
    var body: some View {
        VStack(spacing: 35) {
            
            // MARK: Days ...
            let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            
            // MARK: Header
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(currentDate.getYearDecription())
                        .font(.caption)
                    
                    Text(currentDate.getMonthDecription())
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                Spacer(minLength: 0)
                
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                
                Button {
                    withAnimation {
                        currentMonth += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            
            // MARK: Day
            HStack(spacing: 0) {
                ForEach(days, id: \.self) {
                    Text($0)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // MARK: Dates
            /// Lazy Grid
            
            let collumns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: collumns, spacing: 15) {
                ForEach(extractDate()) { value in
                    if value.day != -1 {
                        CardView(value: value)
                    } else {
                        Spacer()
                    }
                }
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onEnded(
                    { value in
                        if value.translation.width < 0 {
                            withAnimation {
                                currentMonth += 1
                            }
                        }
                        
                        if value.translation.width > 0 {
                            withAnimation {
                                currentMonth -= 1
                            }
                        }
                    }
                )
        )
        .onChange(of: currentMonth) {
            currentDate = getCurrentDay()
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValueModel) -> some View {
        VStack {
            if let task = calendarTask.first(where: { task in
                return isSameDay(date1: task.taskDate, date2: value.date)
            }) {
                Text("\(value.day)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(isSameDay(date1: task.taskDate, date2: currentDate) ?  .miamiWhite : .primary)
                Spacer()
                
                Circle()
                    .foregroundStyle(isSameDay(date1: task.taskDate, date2: currentDate) ?  .miamiWhite : .miamiLightRed)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 8, height: 8)
            } else {
                
                Text("\(value.day)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(isSameDay(date1: value.date, date2: currentDate) ?  .miamiWhite : .primary)
                Spacer()
            }
        }
        .padding(.vertical, 9)
        .frame(width: 40, height: 60, alignment: .top)
        .background {
            Capsule()
                .foregroundStyle(.miamiLightRed)
                .opacity(isSameDay(date1: value.date, date2: currentDate)
                         ? 1
                         : 0 )
        }
        .onTapGesture {
            let impactHeavy = UIImpactFeedbackGenerator(style: .soft)
            impactHeavy.impactOccurred()
            
            currentDate = value.date
        }
    }
    
}

extension DatePickerView {
    
    // Checking dates...
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func getCurrentDay() -> Date {
        let calendar = Calendar.current
        let date = Date()
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: date) else { return Date() }
        
        if date.getYear() == currentMonth.getYear() &&
            date.getMonth() == currentMonth.getMonth() {
            return currentMonth
        }
        
        if date.getYear() > currentMonth.getYear() {
            guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date().endOfMonth()) else {
                return Date().endOfMonth()
            }
            return currentMonth
        }
        
        if date.getYear() < currentMonth.getYear() {
            guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date().startOfMonth()) else {
                return Date().startOfMonth()
            }
            return currentMonth
        }
        
        // Getting Current Month Date
        if date.getMonth() > currentMonth.getMonth() {
            guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date().endOfMonth()) else {
                return Date().startOfMonth()
            }
            return currentMonth
        }
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date().startOfMonth()) else {
            return Date().startOfMonth()
        }
        return currentMonth
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        // Getting Current Month Date
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else { return Date() }
        
        return currentMonth
    }
    
    func extractDate() -> [DateValueModel] {
        let calendar = Calendar.current
        
        // Getting Current Month Date
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValueModel in
            let day = calendar.component(.day, from: date)
            return DateValueModel(day: day, date: date)
        }
        
        // adding offset days to get exact week days
        let firstWeekDay = calendar.component(.weekday, from: days.first?.date ?? .now)
        
        for _ in 0..<firstWeekDay - 1 {
            days.insert(DateValueModel(day: -1, date: Date()), at: 0)
        }
        
        
        let impactHeavy = UIImpactFeedbackGenerator(style: .soft)
        impactHeavy.impactOccurred()
        
        return days
        
    }
}
