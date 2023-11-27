//
//  HeaderGoalProgress+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 11/11/23.
//

import ComposableArchitecture
import SwiftUI
import Charts

extension HeaderGoalProgress {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        let progress: CGFloat
        let isCollapse: Bool
        
        init(store: StoreOf<Feature>, progress: CGFloat) {
            self.store = store
            self.progress = progress
            
            self.isCollapse = progress > 0.6
        }
        
        var body: some SwiftUI.View {
            
            VStack(alignment: .leading, spacing: 0) {
                
                
                if isCollapse {
                    VStack(alignment: .leading, spacing: 0){
                        Text("goal.collapse.title")
                            .font(.caption)
                        
                        Spacer()
                        
                        HStack(spacing: 16) {
                            ChartView(width: 60, height: 60, isCollapse: true)
                            if isCollapse {
                                Text("goal.pie.tip")
                                    .font(.caption2)
                            }
                            
                        }
                    }
                    .hSpacing(.leading)
                    .padding(.vertical, 16)
                } else {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 24 - (12 * progress)) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("goal.remining.cash.label")
                                .font(.caption)
                            
                            Text("$15,145.00")
                                .font(.title.bold())
                                .fontDesign(.rounded)
                        }
                        .hSpacing(.leading)
                        
                        
                        
                        HStack(alignment: .center, spacing: 0) {
                            HStack {
                                Image(systemName: "chart.dots.scatter") // TODO: change currency when changing cell phone language
                                    .font(.title2)
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("goal.label.income")
                                        .font(.caption2)
                                    Text("$10,000.00")
                                        .font(.callout.bold())
                                        .fontDesign(.rounded)
                                }
                            }
                            .hSpacing(.center)
                            Divider()
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                            
                            HStack {
                                Image(systemName: "chart.bar.xaxis") // TODO: change currency when changing cell phone language
                                    .font(.title2)
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("goal.label.expectation")
                                        .font(.caption2)
                                    Text("$10,000.00")
                                        .font(.callout.bold())
                                        .fontDesign(.rounded)
                                }
                            }
                            .hSpacing(.center)
                        }
                        .frame(height: 60 - (8 * progress))
                        .background(.lotion, in: .rect(cornerRadius: 8))
                    }
                }
                
            }
            .foregroundStyle(.grey900)
            .animation(.linear, value: progress)
            .transition(.identity.combined(with: .opacity))
        }
        
    }
}

struct ChartView: View {
    let width: CGFloat
    let height: CGFloat
    
    var isCollapse: Bool = false
    
    var data: [(type: String, amount: Double)] {
        [
            (type: "dog", amount: 5),
            (type: "cat", amount: 10)
        ]
    }
    
    let numbers: [Double] = [5, 1, 8, 3]
    
    let stops = [
        Gradient.Stop(color: .red, location: 0.0),
        Gradient.Stop(color: .red, location: 0.5),
        Gradient.Stop(color: .green, location: 0.50001),
        Gradient.Stop(color: .green, location: 1.0)
    ]
    
    var body: some View {
        Chart {
            if isCollapse {
                ForEach(data, id: \.type) { dataItem in
                    SectorMark(
                        angle: .value("Type", dataItem.amount),
                        innerRadius: .ratio(0.7),
                        angularInset: 1
                    )
                    .cornerRadius(5)
                    .opacity(dataItem.type == "dog" ? 1 : 0.5)
                    .foregroundStyle(dataItem.type == "dog" ? Color.cute800.gradient : Color.grey300.gradient)
                }
                
            } else {
                
                //                RuleMark(y: .value("Limit", 6))
                //                    .foregroundStyle(.red.gradient)
                //                    .annotation(position: .top, alignment: .topLeading) {
                //                        Text("average 6")
                //                    }
                
                ForEach(Array(numbers.enumerated()), id: \.offset) { index, value in
                    LineMark(
                        x: .value("", index),
                        y: .value("", value)
                    )
                    .foregroundStyle(Color.grey600.gradient)
                    .interpolationMethod(.cardinal)
                    .lineStyle(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                    
                    if numbers.last == value  {
                        PointMark(
                            x: .value("Index", index),
                            y: .value("", value)
                        )
                    }
                }
            }
        }
        .chartYScale(domain: 0...15)
        .chartYAxis(.hidden)
        .chartXAxis(.hidden)
        .frame(width: width)
    }
}
