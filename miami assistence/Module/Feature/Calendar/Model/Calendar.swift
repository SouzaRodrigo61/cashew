//
//  Task.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 05/07/23.
//

import Foundation

struct CalendarModel: Identifiable {
    var id =  UUID().uuidString
    var title: String
    var time: Date = Date()
}

struct CalendarMetaData: Identifiable {
    var id = UUID().uuidString
    var task: [CalendarModel]
    var taskDate: Date
}

func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

var calendarTask: [CalendarMetaData] = [
    .init(
        task: [
            .init(title: "Talk to iJustine"),
            .init(title: "iPhone 13 Great Design Change"),
            .init(title: "Nothing Much Working !!")
        ],
        taskDate: getSampleDate(offset: 1)
    ),
    .init(
        task: [
            .init(title: "Talk to iJustine"),
            .init(title: "iPhone 13 Great Design Change"),
            .init(title: "Nothing Much Working !!")
        ],
        taskDate: getSampleDate(offset: -3)
    ),
    .init(
        task: [
            .init(title: "testestes"),
        ],
        taskDate: getSampleDate(offset: -8)
    ),
    .init(
        task: [
            .init(title: "iPhone 13 Great Design Change"),
        ],
        taskDate: getSampleDate(offset: 10)
    ),
    .init(
        task: [
            .init(title: "Nothing Much Working !!")
        ],
        taskDate: getSampleDate(offset: -22)
    ),
    .init(
        task: [
            .init(title: "iPhone 13 Great Design Change"),
        ],
        taskDate: getSampleDate(offset: 15)
    ),
    .init(
        task: [
            .init(title: "Kavsoft App Updates.."),
        ],
        taskDate: getSampleDate(offset: -20)
    ),
]
