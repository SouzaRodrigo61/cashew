//
//  TaskModel.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 08/07/23.
//

import Foundation
import SwiftUI

struct TaskManagementModel: Identifiable {
    var id: UUID = .init()
    var title: String
    var createdAt: Date = .init()
    var isCompleted: Bool = false
    var tint: Color
}

var sampleTasks: [TaskManagementModel] = [
    .init(title: "Record Video", createdAt: .updateHour(-5), isCompleted: true, tint: .miamiRed),
    .init(title: "Record Video", createdAt: .updateHour(-3), isCompleted: false, tint: .miamiGray),
    .init(title: "Record Video", createdAt: .updateHour(-4), isCompleted: true, tint: .miamiPurple),
    .init(title: "Record Video", createdAt: .updateHour(0), isCompleted: false, tint: .yellow),
    .init(title: "Record Video", createdAt: .updateHour(2), isCompleted: true, tint: .purple),
    .init(title: "Record Video", createdAt: .updateHour(1), isCompleted: false, tint: .green),
    .init(title: "Record Video", createdAt: .updateHour(6), isCompleted: false, tint: .orange)
]

