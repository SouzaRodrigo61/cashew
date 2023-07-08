//
//  ScheduleViewModel.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 03/07/23.
//

import SwiftUI
import Observation

@Observable
class ScheduleViewModel {
    var store: [Schedule] = [
        Schedule(title: "Reunião de equipe", description: "Discutir os próximos projetos e metas", date: "2023-07-03 09:00:00".formattedDate()),
        Schedule(title: "Almoço", description: "Hora de recarregar as energias", date: "2023-07-03 12:30:00".formattedDate()),
        Schedule(title: "Apresentação de vendas", description: "Mostrar os resultados do último trimestre", date: "2023-07-03 14:00:00".formattedDate()),
        Schedule(title: "Treino na academia", description: "Exercitar o corpo e a mente", date: "2023-07-04 07:00:00".formattedDate()),
        Schedule(title: "Sessão de brainstorming", description: "Gerar ideias para novos produtos", date: "2023-07-04 10:00:00".formattedDate()),
        Schedule(title: "Pausa para café", description: "Recarregar as energias e socializar", date: "2023-07-04 15:30:00".formattedDate()),
        Schedule(title: "Reunião com o cliente", description: "Discutir detalhes do novo projeto", date: "2023-07-05 11:00:00".formattedDate()),
        Schedule(title: "Lançamento do produto", description: "Evento para apresentar o novo produto", date: "2023-07-05 15:00:00".formattedDate()),
        Schedule(title: "Happy hour", description: "Momento de descontração com a equipe", date: "2023-07-05 18:00:00".formattedDate()),
        Schedule(title: "Feriado", description: "Dia de descanso e lazer", date: "2023-07-06 00:00:00".formattedDate())
    ]
    
    var currentWeek: [Date] = []
    var currentDay: Date = Date()
    var currentWeekOffset: Int = 0
    var filteredSchedule: [Schedule]? = nil
    
    init() {
        fetchCurrentWeek()
        filterTodayAppointment()
    }
    
    // MARK: Fetch Current Week
    func fetchCurrentWeek() {
        DispatchQueue.main.async {
            
            self.currentWeek.removeAll()
            
            let today = self.getCurrentWeek()
            let calendar = Calendar.current
            
            let week = calendar.dateInterval(of: .weekOfMonth, for: today)
            guard let firstWeekDay = week?.start else { return }
            
            (0...6).forEach { day in
                if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                    self.currentWeek.append(weekday)
                }
            }
            
            
            let impactHeavy = UIImpactFeedbackGenerator(style: .soft)
            impactHeavy.impactOccurred()
        }
    }
    
    
    func getCurrentWeek() -> Date {
        let calendar = Calendar.current
        
        // Getting Current Month Date
        guard let currentMonth = calendar.date(byAdding: .weekOfMonth, value: currentWeekOffset, to: .now) else { return Date() }
        
        return currentMonth
    }
    
    
    // MARK: Extracting Date
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    // MARK: Checking if current Date is Today
    func isToday(date: Date) -> Bool {
        let current = Calendar.current
        
        return current.isDate(currentDay, inSameDayAs: date)
    }
    
    // MARK: Filter today appointment
    func filterTodayAppointment() {
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            
            let filtered = self.store.filter {
                return calendar.isDate($0.date, inSameDayAs: self.currentDay)
            }
            
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredSchedule = filtered
                }
            }
        }
    }
    
    // MARK: Checking if the currentHour is task Hour
    func isCurrentHour(date: Date) -> Bool {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        
        guard calendar.isDate(Date(), inSameDayAs: date) else { return false }
        
        return hour == currentHour
        
    }
}
