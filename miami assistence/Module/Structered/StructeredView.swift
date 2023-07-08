//
//  MainView.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 06/07/23.
//

import SwiftUI

struct StructeredView: View {
    
    @State private var planner: DayPlanner = DayPlanner()
    
    var body: some View {
        
        let mondayOfTheCurrentDate = planner.startDateOfWeek(from: planner.currentDate)
        
        VStack {
            HStack {
                Text(mondayOfTheCurrentDate.monthYYYY())
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                HStack {
                    Image(systemName: "calendar")
                    Image(systemName: "tray.fill")
                    Image(systemName: "gear")
                }
                .font(.title)
            }
            .padding([.top, .leading, .trailing])
            
            SwipeableStack(planner.startDateOfWeekInAYear(), jumpTo: mondayOfTheCurrentDate) { date, pos, _ in
                WeekView(of: date, viewPosition: pos)
            }
            .frame(maxHeight: 100)
            
            VStack {
                Text("Date - \(mondayOfTheCurrentDate)")
                Spacer()
                Text("planner.isCurrent(.now): \(planner.currentDate)")
                Spacer()
            }
            .padding()
            .hCenter()
            .background(.miamiDarkGraySecond)
            .cornerRadius(16, corners: [.topLeft, .topRight])
            .ignoresSafeArea()
            .overlay(alignment: .bottomTrailing) {
                CreateButton()
            }
        }
        .environment(planner)
        .preferredColorScheme(.dark)
    }
}

struct WeekView: View {
    @Environment(DayPlanner.self) private var planner
    let date: Date
    
    var viewPosition: ViewPosition = .center
    
    init(of date: Date, viewPosition: ViewPosition) {
        self.date = date
        self.viewPosition = viewPosition
    }
    
    var body: some View {
        let datesInAWeek = planner.datesInAWeek(from: date)
        
        HStack {
            Spacer()
            ForEach(datesInAWeek.indices, id: \.self) { weekIndex in
                let weekDay = datesInAWeek[weekIndex]
                
                VStack {
                    Text(weekDay.weekDayAbbrev())
                    SizedBox(height: 5)
                    Text(weekDay.dayNum())
                        .fontWeight(.bold)
                        .foregroundStyle(planner.isCurrent(weekDay) ? .miamiBlack : .miamiWhite )
                        .background {
                            if planner.isCurrent(weekDay) {
                                Circle()
                                    .fill(.primary)
                                    .frame(width: 30, height: 30)
                            }
                        }
                }
                .onTapGesture {
                    
                    let impactHeavy = UIImpactFeedbackGenerator(style: .rigid)
                    impactHeavy.impactOccurred()
                    
                    planner.setCurrentDate(to: weekDay)
                }
                
                
                Spacer()
            }
        }
        .onChange(of: date) { _, d in
            if viewPosition == .center {
                let position = planner.currentPositionInWeek()
                let datesInAWeek = planner.datesInAWeek(from: d)
                
                let filtering = datesInAWeek.filter { date in
                    planner.sameDay(date1: date, date2: Date())
                }
                
                planner.setCurrentDate(to: filtering.isEmpty
                                       ? planner.startDateOfWeek(from: datesInAWeek[position])
                                       : Date())
            }
        }
    }
}

struct CreateButton: View {
    @State private var isPresented = false
    
    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            Image(systemName: "plus")
                .imageScale(.large)
                .foregroundStyle(.miamiWhite)
                .padding()
                .background {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.green)
                }
                .padding(.trailing)
        }
        .sheet(isPresented: $isPresented) {
            Text("Hello")
        }
        
    }
}
