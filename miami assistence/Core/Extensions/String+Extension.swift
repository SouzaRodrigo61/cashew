//
//  String+Extension.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 22/06/23.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)")
    }

    ///
    /// This function serves to add arguments needed for custom string handling and localization.
    ///
    ///     Text("by_user".localized(args: "Rodrigo", "Abestado"))
    ///          .font(.system(size: 40))
    ///
    ///
    func localized(args: CVarArg...) -> String {
        return String(format: localized, arguments: args)
    }
    
    
    ///
    /// This function serves to add formatted string and return Date.
    ///
    func formattedDate(with format: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else { return .now }
        return date
    }
    
    func calculateHourByValue(with value: Int = 60) -> String {
        
        // Defina o formato de exibição da hora
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        // Converta a string em um objeto Date
        if let hour = dateFormatter.date(from: self) {
            // Use Calendar para adicionar uma hora
            let calendar = Calendar.current
            if let newHour = calendar.date(byAdding: .minute, value: value, to: hour) {
                // Converta a nova hora em uma string formatada
                let newHourString = dateFormatter.string(from: newHour)
                return newHourString
            }
        } 
        
        return "Error"
    }
}
