//
//  Date+Extension.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 05/07/23.
//

import Foundation

extension Date {
    
    func getMonthDecription() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        
        return formatter.string(from: self)
    }
    
    func getYearDecription() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        
        return formatter.string(from: self)
    }
    
    func getDay() -> Int {
        return Calendar.current.component(.day, from: self)
    }
    
    func getMonth() -> Int {
        return Calendar.current.component(.month, from: self)
    }
    
    func getYear() -> Int {
        return Calendar.current.component(.year, from: self)
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    /// Extending Daate to get Current Month Dates...
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        // Getting start Date
        guard let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self)) else { return [] }
        
        guard let range = calendar.range(of: .day, in: .month, for: startDate) else { return [] }
        
        return range.compactMap { day -> Date in
            guard let dates = calendar.date(byAdding: .day, value: day - 1, to: startDate) else {
                return .now
            }
            
            return dates
        }
    }
    
    /// Extending Daate to get Current Month Dates...
    func weekOfMonth() -> [Date] {
        let calendar = Calendar.current
        
        guard let range = calendar.range(of: .day, in: .weekOfMonth, for: self) else { return [] }
        
        return range.compactMap { day -> Date in
            guard let dates = calendar.date(byAdding: .day, value: day, to: self) else {
                return .now
            }
            
            return dates
        }
    }
    
    func monthYYYY() -> String {
        return self.formatted(.dateTime .month(.wide) .year())
    }
    
    
    func dayMonthAbbrev() -> String {
        return self.formatted(.dateTime .day() .month(.abbreviated))
    }
    
    func weekDayAbbrev() -> String {
        return self.formatted(.dateTime .weekday(.abbreviated))
    }
    
    func dayNum() -> String {
        return self.formatted(.dateTime .day())
    }
    
    func week() -> String {
        return self.formatted(.dateTime .weekday(.abbreviated) .day(.twoDigits) .month(.abbreviated)).replacing(",", with: "")
    }
    
    func validateIsToday() -> String {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date()) // Get the start of today's date

        if calendar.isDate(self, inSameDayAs: today) {
            // The input date is today
            return "calendar.date.today".localized
        } else {
            // The input date is not today
            return self.formatted(.dateTime .weekday(.abbreviated))
        }
    }
    
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
    
    
    /// Fetching Week Based on given Date
    func fetchWeek(_ date: Date = .init()) -> [Days] {
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: date)
        
        var week: [Days] = []

        
        if let previousDay = calendar.date(byAdding: .day, value: -1, to: startOfDate) {
            week.append(.init(date: previousDay, isBefore: previousDay < .now))
        }
        week.append(.init(date: startOfDate, isBefore: false))
        
        if let nextDay = calendar.date(byAdding: .day, value: 1, to: startOfDate) {
            week.append(.init(date: nextDay, isBefore: nextDay > .now))
        }
        
        return week
    }
    
    // Creating Next Day
    func createNextDay() -> Days {
        let calendar = Calendar.current

        guard let nextDay = calendar.date(byAdding: .day, value: 1, to: self) else {
            return .init(date: self, isBefore: self < .now)
        }
        
        return .init(date: nextDay, isBefore: nextDay < .now)
    }
    
    
    // Creating Previous Day
    func createPreviousDay() -> Days {
        let calendar = Calendar.current

        guard let day = calendar.date(byAdding: .day, value: -1, to: self) else {
            return .init(date: self, isBefore: false)
        }
        
        return .init(date: day, isBefore: day < .now)
    }
    
    struct Days: Identifiable, Equatable {
        var id: UUID = .init()
        var date: Date
        var isBefore: Bool
    }
}
