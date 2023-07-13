//
//  TaskRowView.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 08/07/23.
//

import SwiftUI

struct TaskRowView: View {
    @Binding var task: TaskManagementModel
    
    var indicatorColor: Color {
        if task.isCompleted {
            return .green
        }
        
        return task.createdAt.isSameHour ? .miamiDarkBlue : (task.createdAt.isPast ? .miamiRed : .miamiBlack)
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Circle()
                .fill(indicatorColor)
                .frame(width: 10, height: 10)
                .padding(4)
                .background(.miamiWhite.shadow(.drop(color: .miamiBlack.opacity(0.1), radius: 3)), in: .circle)
                .overlay {
                    Circle()
                        .frame(width: 50, height: 50)
                        .blendMode(.destinationOver)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                task.isCompleted.toggle()
                            }
                        }
                }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(task.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.miamiBlack)
                
                Label(task.createdAt.format("hh:mm a"), systemImage: "clock")
                    .font(.caption)
                    .foregroundStyle(.miamiBlack)
            }
            .hSpacing(.leading)
            .padding(20)
            .background(task.tint, in: .rect(cornerRadius: 25))
            .strikethrough(task.isCompleted, pattern: .solid, color: .miamiBlack)
            .padding(.trailing)
            .offset(y: -25)
        }
    }
}

#Preview {
    ContentView()
}
