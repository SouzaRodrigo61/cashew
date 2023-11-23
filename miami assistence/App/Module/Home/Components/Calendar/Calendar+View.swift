//
//  Calendar.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 21/11/23.
//

import Foundation
import SwiftUI

enum ContentCalendar {
    struct View: SwiftUI.View {
        
        @State private var selectedMonth: Date = .currentMonth
        @State private var selectedDate: Date = .now
        
        
        /// Animation Namespace
        @Namespace private var animation
        
        var body: some SwiftUI.View {
            GeometryReader {
                let safeArea = $0.safeAreaInsets
                
                Home(safeArea)
                    .ignoresSafeArea(.container, edges: .top)
            }
        }
        
        
        @ViewBuilder
        func Home(_ safeArea: EdgeInsets) -> some SwiftUI.View {
            let maxHeight = calendarHeight(with: safeArea) - (calendarTitleViewHeight + weekLabelHeight + safeArea.top + 50 + topPadding + bottomPadding)
            
            
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    
                    /// Sticky Header
                    CalendarView(safeArea)
                    
                    VStack(spacing: 15) {
                        ForEach(1...15, id: \.self) { _ in
                            CardView()
                                .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1 : 0)
                                        .scaleEffect(phase.isIdentity ? 1 : 0.75)
                                        .blur(radius: phase.isIdentity ? 0 : 10)
                                }
                        }
                    }
                    .padding(15)
                }
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(CustomScrollBehavior(maxHeight: maxHeight))
        }
        
        /// Test Card View ( For Scroll Content )
        @ViewBuilder
        func CardView() -> some SwiftUI.View {
            RoundedRectangle(cornerRadius: 15)
                .fill(.blue.gradient)
                .frame(height: 70)
                .overlay(alignment: .leading) {
                    HStack(spacing: 12) {
                        Circle()
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 100, height: 5)
                            
                            
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 70, height: 5)
                        }
                    }
                    .padding(.horizontal, 15)
                    .foregroundStyle(.white.opacity(0.25))
                }
        }
        
        @ViewBuilder
        func CalendarView(_ safeArea: EdgeInsets) -> some SwiftUI.View {
            GeometryReader {
                let size = $0.size
                let minY = $0.frame(in: .scrollView(axis: .vertical)).minY
                /// Converting Scroll Into Progress
                let maxHeight = size.height - (calendarTitleViewHeight + weekLabelHeight + safeArea.top + 50 + topPadding + bottomPadding - 50)
                let progress = max(min((-minY / maxHeight), 1), 0)
                
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(currentMonth)
                        .font(.system(size: 35 - (10 * progress)))
                        .offset(y: -50 * progress)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .overlay(alignment: .topLeading) {
                            GeometryReader {
                                let size = $0.size
                                
                                Text(currentYear)
                                    .font(.system(size: 25 - (10 * progress)))
                                    .offset(x: (size.width + 5) * progress, y: progress * 3)
                            }
                        }
                        .hSpacing(.leading)
                        .overlay(alignment: .topTrailing) {
                            HStack(spacing: 15) {
                                Button("", systemImage: "chevron.left") {
                                    /// Update To previous Month
                                    withAnimation(.smooth) {
                                        monthUpdate(false)
                                    }
                                }
                                .contentShape(.rect)
                                
                                Button("", systemImage: "chevron.right") {
                                    /// Update To previous Month
                                    withAnimation(.smooth) {
                                        monthUpdate(true)
                                    }
                                }
                                .contentShape(.rect)
                            }
                            .font(.title3)
                            .foregroundStyle(.primary)
                            .offset(x: 150 * progress)
                        }
                        .frame(height: calendarTitleViewHeight)
                    
                    VStack(spacing: 0) {
                        /// Day labels
                        HStack(spacing: 0) {
                            ForEach(Calendar.current.weekdaySymbols, id: \.self) { symbol in
                                Text(symbol.prefix(3).capitalized)
                                    .font(.caption)
                                    .frame(maxWidth: .infinity)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .frame(height: weekLabelHeight, alignment: .bottom)
                        
                        /// Calendar Grid View
                        LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 7), spacing: 0) {
                            ForEach(selectedMonthDates) { day in
                                Text(day.shortSymbol)
                                    .foregroundStyle(day.ignored ? .secondary : .primary)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .overlay(alignment: .bottom) {
                                        if day.date.compareDate(selectedDate) {
                                            Circle()
                                                .fill(.white)
                                                .frame(width: 5, height: 5)
                                                .offset(y: progress * -2 )
                                                .matchedGeometryEffect(id: "currentlyDate", in: animation)
                                        }
                                    }
                                    .contentShape(.rect)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedDate = day.date
                                        }
                                    }
                            }
                        }
                        .frame(height: calendarGridHeight - ((calendarGridHeight - 50) * progress), alignment: .top)
                        .offset(y: (monthProgress * -50) * progress)
                        .contentShape(.rect)
                        .clipped()
                    }
                    .offset(y: progress * -50)
                    
                    Button {
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(height: 4)
                            .padding(.horizontal, 100)
                    }
                    .padding(.bottom, bottomPadding)
                }
                .onChange(of: progress, { oldValue, newValue in
                    dump(newValue, name: "progress")
                })
                .foregroundStyle(.white)
                .padding(.horizontal, horizontalPadding)
                .padding(.top, topPadding)
                .padding(.top, safeArea.top)
                .padding(.bottom, bottomPadding)
                .frame(maxWidth: .infinity)
                .frame(height: size.height - (maxHeight * progress), alignment: .top)
                .background(.red.gradient)
                /// Sticking it to top
                .clipped()
                .contentShape(.rect)
                .offset(y: -minY)
            }
            .frame(height: calendarHeight(with: safeArea))
            .zIndex(1000)
        }
        
        /// View Heights & Paddings
        var calendarTitleViewHeight: CGFloat { 75.0 }
        var horizontalPadding: CGFloat { 15.0 }
        var topPadding: CGFloat { 15.0 }
        var bottomPadding: CGFloat { 5.0 }
        var weekLabelHeight: CGFloat { 30.0 }
        
        func calendarHeight(with safeArea: EdgeInsets) -> CGFloat {
            calendarTitleViewHeight + weekLabelHeight + calendarGridHeight + safeArea.top + topPadding + bottomPadding
        }
        
        var calendarGridHeight: CGFloat { CGFloat(selectedMonthDates.count / 7) * 50 }
        
        var currentMonth: String { selectedMonth.format("MMMM").capitalized }
        var currentYear: String { selectedMonth.format("YYYY") }
        var selectedMonthDates: [Date.Day] { selectedMonth.extractDates() }
        
        var monthProgress: CGFloat {
            let calendar = Calendar.current
            if let index = selectedMonthDates.firstIndex(where: { calendar.isDate($0.date, inSameDayAs: selectedDate) }) {
                return CGFloat(index / 7).rounded()
            }
            
            return 1.0
        }
        
        /// Month Increment/Decrement
        func monthUpdate(_ increment: Bool = true) {
            let calendar = Calendar.current
            guard let month = calendar.date(byAdding: .month, value: increment ? 1 : -1, to: selectedMonth) else { return }
            guard let date = calendar.date(byAdding: .month, value: increment ? 1 : -1, to: selectedDate) else { return }
            
            selectedMonth = month
            selectedDate = date
        }
    }
}
