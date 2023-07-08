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

var tasks: [TaskManagementModel] = [
    .init(title: "Record Video", createdAt: .updateHour(-5), isCompleted: true, tint: .miamiRed),
    .init(title: "Record Video", createdAt: .updateHour(-3), isCompleted: true, tint: .miamiGray),
    .init(title: "Record Video", createdAt: .updateHour(-4), isCompleted: true, tint: .miamiPurple),
    .init(title: "Record Video", createdAt: .updateHour(0), isCompleted: true, tint: .yellow),
    .init(title: "Record Video", createdAt: .updateHour(2), isCompleted: true, tint: .purple),
    .init(title: "Record Video", createdAt: .updateHour(1), isCompleted: true, tint: .green),
    .init(title: "Record Video", createdAt: .updateHour(6), isCompleted: true, tint: .orange)
]

