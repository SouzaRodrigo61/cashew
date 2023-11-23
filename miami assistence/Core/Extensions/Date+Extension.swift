//
//  Date+Extension.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 05/07/23.
//

import Foundation

extension Date {
    
    func format(_ format: String) -> String {
        let formatted = DateFormatter()
        formatted.dateFormat = format
        
        return formatted.string(from: self)
    }
    
    static var currentMonth: Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(from: calendar.dateComponents([.month, .year], from: Date.now)) else { return Date.now }
        
        return currentMonth
    }
    
    /// Extracting Dates for the Given Month
    func extractDates() -> [Day] {
        var days: [Day] = []
        let calendar = Calendar.current
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd"
        
        guard let range = calendar.range(of: .day, in: .month, for: self)?.compactMap({ value -> Date? in
            return calendar.date(byAdding: .day, value: value - 1, to: self)
        }) else { return days }
        
        let firstWeekDay = calendar.component(.weekday, from: range.first!)
        for index in Array(0..<firstWeekDay - 1).reversed() {
            guard let date = calendar.date(byAdding: .day, value: -index - 1, to: range.first!) else { return days }
            let shortSymbol = formatter.string(from: date)
            
            days.append(.init(shortSymbol: shortSymbol, date: date, ignored: true))
        }
        
        
        range.forEach {
            let shortSymbol = formatter.string(from: $0)
            days.append(.init(shortSymbol: shortSymbol, date: $0))
        }
        
        let lastWeekDay = 7 - calendar.component(.weekday, from: range.last!)
        if lastWeekDay > 0 {
            for index in 0..<lastWeekDay {
                guard let date = calendar.date(byAdding: .day, value: index + 1, to: range.last!) else { return days }
                let shortSymbol = formatter.string(from: date)
                
                days.append(.init(shortSymbol: shortSymbol, date: date, ignored: true))
            }
        }
        
        return days
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
    
    func hourMinute() -> String {
        self.formatted(.dateTime .hour() .minute())
    }
    
    func week() -> String {
        return self.formatted(.dateTime .day(.twoDigits) .month(.wide)).replacing(",", with: "")
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
    
    /// Fetching Week Based on given Date
    func fetchWeeks(_ date: Date = .init()) -> [Week] {
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: date)
        
        var week: [Week] = []
        let weekForDate = calendar.dateInterval(of: .weekOfMonth, for: startOfDate)
        guard let startOfWeek = weekForDate?.start else { return [] }
        
        /// Iterating to get the Full Week
        (0..<7).forEach { index in
            if let weekDay = calendar.date(byAdding: .day, value: index, to: startOfWeek) {
                week.append(.init(date: weekDay))
            }
        }
        
        return week
    }
    
    // Creating Next Week, based on the Last Current Week's Date
    func createNextWeek() -> [Week] {
        let calendar = Calendar.current
        let startOfLastDate = calendar.startOfDay(for: self)
        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfLastDate) else { return [] }
        
        return fetchWeeks(nextDate)
    }
    
    // Creating Previous Week, based on the Last Current Week's Date
    func createPreviousWeek() -> [Week] {
        let calendar = Calendar.current
        let startOfFirstDate = calendar.startOfDay(for: self)
        guard let previousDate = calendar.date(byAdding: .day, value: -1, to: startOfFirstDate) else { return [] }
        
        return fetchWeeks(previousDate)
    }
    
    // Creating Next Hour Minute
    func createNextHourMinute(into value: Int = 1) -> String {
        let calendar = Calendar.current

        guard let nextDay = calendar.date(byAdding: .hour, value: value, to: self) else {
            return ""
        }
        
        return nextDay.hourMinute()
    }
    
    // TODO: Compact this code
    func fetchHourOfDay(_ date: Date = .init()) -> [String] {

        // Calendário para manipular datas e horas
        let calendar = Calendar.current

        // Definir o formato de exibição da hora
        let formatedHour = DateFormatter()
        formatedHour.dateFormat = "HH:mm"

        // Definir a hora de início e a hora de término
        guard let initialHour = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: date) else { return [] }
        guard let lastHour = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: date) else { return [] }


        if let now = calendar.date(bySettingHour: calendar.component(.hour, from: date), minute: calendar.component(.minute, from: date), second: 0, of: date),
            now >= initialHour && now <= lastHour {
            var arrayHour: [String] = []
            var currentHour = initialHour

            // Loop para adicionar horas em incrementos de 15 minutos
            
            while currentHour <= lastHour {
                let hour = formatedHour.string(from: currentHour)
                arrayHour.append(hour)

                if let nextHour = calendar.date(byAdding: .minute, value: 15, to: currentHour) {
                    currentHour = nextHour
                } else {
                    break
                }
            }

            // Agora você tem um array de horas em incrementos de 15 minutos dentro do intervalo permitido
            return arrayHour
        } else {
            return []
        }
    }
    
    // TODO: Compact this code
    func fetchIndexByDeviceHour() -> Int {
        
        // Define the time display format, including the date
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "yyyy-MM-dd HH:mm"

        // Create a list of times in 15-minute increments (example)
        var timeArray: [String] = []
        guard var currentTime = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self) else { return 0 }
        guard let lastTime = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self) else { return 0 }
        
        guard let actualDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date()) else { return 0 }
        guard let selfDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self) else { return 0 }

        guard actualDate == selfDate else { return 0 }
        

        while currentTime <= lastTime {
            let formattedTime = timeFormat.string(from: currentTime)
            timeArray.append(formattedTime)

            if let nextTime = Calendar.current.date(byAdding: .minute, value: 15, to: currentTime) {
                currentTime = nextTime
            } else {
                break
            }
        }

        // Get the current time from the device
        guard let currentDeviceTime = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: Date()), minute: Calendar.current.component(.minute, from: Date()), second: 0, of: self) else { return 0 }

        // Find the next corresponding time in the list
        var correspondingIndex: Int = 0
        var smallestMinuteDifference = Int.max
        
        for (index, time) in timeArray.enumerated() {
            if let timeDate = timeFormat.date(from: time) {
                let difference = Calendar.current.dateComponents([.hour, .minute], from: currentDeviceTime, to: timeDate)
                let minuteDifference = difference.hour! * 60 + difference.minute!

                if minuteDifference >= 0 && minuteDifference < smallestMinuteDifference {
                    smallestMinuteDifference = minuteDifference
                    correspondingIndex = index
                }
            }
        }
        
        return correspondingIndex
    }
    
    func compareDate(_ date: Date) -> Bool {
        guard let comparedDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date) else { return false }
        guard let selfDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self) else { return false }
        
        return comparedDate == selfDate
    }
    
    func isToday() -> Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    func isAfterByDate(_ date: Date) -> Bool {
        self > date
    }
    
    struct Week: Identifiable, Equatable {
        var id: UUID = .init()
        var date: Date
        var activity: Int = 0
    }
    
    struct Days: Identifiable, Equatable {
        var id: UUID = .init()
        var date: Date
        var isBefore: Bool
        var isTomorrow: Bool = false
    }
    
    struct Day: Identifiable, Equatable {
        var id: UUID = .init()
        var shortSymbol: String
        var date: Date
        
        /// Previous / Next Month Excess Dates
        var ignored: Bool = false
    }
}
