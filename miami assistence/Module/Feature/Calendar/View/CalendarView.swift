//
//  CalendarView.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 05/07/23.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        ResponsiveView { prop in
            ScrollView(.vertical) {
                VStack {
                    DatePickerView(currentDate: .now)
                    Spacer()
                }
            }
            .scrollIndicators(.never)
            .frame(width: prop.size.width, height: prop.size.height)
//            .preferredColorScheme(.light)
        }
    }
}
