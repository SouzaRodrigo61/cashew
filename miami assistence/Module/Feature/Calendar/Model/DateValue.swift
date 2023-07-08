//
//  DateValue.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 05/07/23.
//

import Foundation

// Date Value Model...
struct DateValueModel: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
