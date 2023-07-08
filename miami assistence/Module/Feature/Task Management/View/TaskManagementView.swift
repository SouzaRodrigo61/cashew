//
//  TaskView.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 08/07/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TaskManagementView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.miamiWhite)
        
    }
}

struct TaskManagementView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContentView()
}
