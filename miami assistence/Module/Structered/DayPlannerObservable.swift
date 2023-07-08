//
//  DayPlanner.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 06/07/23.
//

import SwiftUI
import Observation

struct MyCalendar {
    private(set) var today = Date()
    private(set) var currentDate: Date
    private(set) var startOfYear: Date
    
    private var calendar = Calendar(identifier: .iso8601)
    private let dateFormatter = DateFormatter()
    
    init() {
        calendar.timeZone = TimeZone.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyyMMdd"

        let todayStr = dateFormatter.string(from: today)
        currentDate = dateFormatter.date(from: todayStr)!
        
        let currentYear = calendar.component(.year, from: currentDate)
        startOfYear = calendar.date(from: DateComponents(year: currentYear, month: 1, day: 1))!
    }
    
    mutating func setCurrentDate(to date: Date) {
        let dateStr = dateFormatter.string(from: date)
        let d = dateFormatter.date(from: dateStr)
        
        if let d {
            currentDate = d
        }
    }
    
    func datesInYear() -> [Date] {
        let currentYear = calendar.component(.year, from: currentDate)
        guard let startOfYear = calendar.date(from: DateComponents(year: currentYear, month: 1, day: 1)) else { return [] }
        guard let range = calendar.range(of: .day, in: .year, for: startOfYear) else { return [] }
        let datesArrayInYear = range.compactMap {
            calendar.date(byAdding: .day, value: $0 - 1, to: startOfYear)
        }
        
        return datesArrayInYear
    }
    
    func datesInWeek(from date: Date) -> [Date] {
        guard let range = calendar.range(of: .weekday, in: .weekOfYear, for: date) else { return [] }
        let datesArrayInWeek = range.compactMap {
            calendar.date(byAdding: .day, value: $0 - 1, to: date)
        }
        
        return datesArrayInWeek
    }
    
    func startDateOfWeekInAYear() -> [Date] {
        let currentWeek = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: startOfYear)
        guard let startOfWeek = calendar.date(from: currentWeek) else { return [] }
        guard let range = calendar.range(of: .weekOfYear, in: .year, for: startOfYear) else { return [] }
        
        let startOfWeekArray = range.compactMap {
            calendar.date(byAdding: .weekOfYear, value: $0, to: startOfWeek)
        }
        
        return startOfWeekArray
    }
    
    
    func startDateOfWeek(from date: Date) -> Date {
        let currentWeek = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        guard let date = calendar.date(from: currentWeek) else { return .now }
        
        return date
    }
    
    func sameDay(date1: Date, date2: Date) -> Bool {
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}

@Observable
class DayPlanner {
    private var model = MyCalendar()
    
    var currentDate: Date {
        return model.currentDate
    }
    
    func setCurrentDate(to date: Date) {
        model.setCurrentDate(to: date)
    }
    
    func dates() -> [Date] {
        model.datesInYear()
    }
    
    func datesInAWeek(from date: Date) -> [Date] {
        model.datesInWeek(from: date)
    }
    
    func startDateOfWeekInAYear() -> [Date] {
        model.startDateOfWeekInAYear()
    }
    
    func startDateOfWeek(from date: Date) -> Date {
        model.startDateOfWeek(from: date)
    }
    
    func isCurrent(_ date: Date) -> Bool {
        model.sameDay(date1: date, date2: currentDate)
    }
    
    func sameDay(date1: Date, date2: Date) -> Bool {
        model.sameDay(date1: date1, date2: date2)
    }
    
    func currentPositionInWeek() -> Int {
        let startOfWeek = startDateOfWeek(from: currentDate)
        let datesInWeek = datesInAWeek(from: startOfWeek)
        guard let position = datesInWeek.firstIndex(of: currentDate) else { return 0 }
        return position
    }
}
