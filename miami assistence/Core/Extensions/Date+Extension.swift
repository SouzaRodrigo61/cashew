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
            week.append(.init(date: nextDay, isBefore: nextDay > .now, isTomorrow: date == .now ? true : false))
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
    
    
    
    // Creating Next Day
    func createNextHourMinute(into value: Int = 1) -> String {
        let calendar = Calendar.current

        guard let nextDay = calendar.date(byAdding: .hour, value: value, to: self) else {
            return ""
        }
        
        return nextDay.hourMinute()
    }
    
    
    // Creating Previous Day
    func createPreviousDay() -> Days {
        let calendar = Calendar.current

        guard let day = calendar.date(byAdding: .day, value: -1, to: self) else {
            return .init(date: self, isBefore: false)
        }
        
        return .init(date: day, isBefore: day < .now)
    }
    
    func fetchHourOfDay(_ date: Date = .init()) -> [String] {

        // Calendário para manipular datas e horas
        let calendar = Calendar.current

        // Definir o formato de exibição da hora
        let formatedHour = DateFormatter()
        formatedHour.dateFormat = "HH:mm"

        // Definir a hora de início e a hora de término
        guard let initialHour = calendar.date(bySettingHour: 6, minute: 0, second: 0, of: date) else { return [] }
        guard let lastHour = calendar.date(bySettingHour: 22, minute: 0, second: 0, of: date) else { return [] }

        // Verificar se a hora atual está dentro do intervalo permitido
        if let now = calendar.date(bySettingHour: calendar.component(.hour, from: date), minute: calendar.component(.minute, from: Date()), second: 0, of: date),
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
    
    func fetchIndexByDeviceHour() -> Int {
        
        // Define the time display format, including the date
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "yyyy-MM-dd HH:mm"

        // Create a list of times in 15-minute increments (example)
        var timeArray: [String] = []
        var currentTime = Calendar.current.date(bySettingHour: 6, minute: 0, second: 0, of: Date())!

        while currentTime <= Calendar.current.date(bySettingHour: 22, minute: 0, second: 0, of: Date())! {
            let formattedTime = timeFormat.string(from: currentTime)
            timeArray.append(formattedTime)

            if let nextTime = Calendar.current.date(byAdding: .minute, value: 15, to: currentTime) {
                currentTime = nextTime
            } else {
                break
            }
        }

        // Get the current time from the device
        var currentDeviceTime = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: Date()), minute: Calendar.current.component(.minute, from: Date()), second: 0, of: Date())!

        // Find the next corresponding time in the list
        var correspondingIndex: Int?
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
        
        return correspondingIndex ?? 0
    }
    
    struct Days: Identifiable, Equatable {
        var id: UUID = .init()
        var date: Date
        var isBefore: Bool
        var isTomorrow: Bool = false
    }
}
