//
//  Header+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 18/08/23.
//

import ComposableArchitecture
import SwiftUI

extension Header {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        let safeArea: EdgeInsets
        
        /// View Heights & Paddings
        var calendarTitleViewHeight: CGFloat { 30.0 }
        var horizontalPadding: CGFloat { 8.0 }
        var topPadding: CGFloat { 16.0 }
        var bottomPadding: CGFloat { 8.0 }
        var spacing: CGFloat { 8.0 }
        var weekLabelHeight: CGFloat { 50 }
        

        
        var body: some SwiftUI.View {
            WithViewStore(store, observe: \.currentDate) { date in
                
                var goalProgressHeight: CGFloat { date.state.isToday() ? 200 : 0 }
                var calendarHeight: CGFloat {
                    calendarTitleViewHeight + weekLabelHeight + goalProgressHeight + safeArea.top + bottomPadding + bottomPadding
                }
                
                GeometryReader {
                    let size = $0.size
                    let minY = $0.frame(in: .scrollView(axis: .vertical)).minY
                    
                    /// Converting Scroll Into Progress
                    let maxHeight = size.height - (calendarTitleViewHeight + weekLabelHeight + 90 + safeArea.top + topPadding + spacing + spacing)
                    let progress = max(min((-minY / maxHeight), 1), 0)
                    
                    VStack(spacing: spacing) {
                        
                        HStack(alignment: .center, spacing: 0) {
                            IfLetStore(store.scope(state: \.today, action: Feature.Action.today)) {
                                HeaderToday.View(store: $0)
                            }
                            .hSpacing(.leading)
                            
                            Spacer()
                            
                            IfLetStore(store.scope(state: \.button, action: Feature.Action.button)) {
                                HeaderButton.View(store: $0)
                            }
                        }
                        
                        IfLetStore(store.scope(state: \.goal, action: Feature.Action.goal)) {
                            HeaderGoalProgress.View(store: $0)
                        }
                        .frame(height: goalProgressHeight - ((goalProgressHeight - 100) * progress), alignment: .top)
                        
                        IfLetStore(store.scope(state: \.slider, action: Feature.Action.slider)) {
                            HeaderSlider.View(store: $0)
                        }
                        .contentShape(.rect)
                        .clipped()
                    }
                    .padding(.horizontal, horizontalPadding)
                    .padding(.top, safeArea.top)
                    .padding(.bottom, bottomPadding)
                    .frame(maxWidth: .infinity)
                    .frame(height: date.state.isToday() ? size.height - (maxHeight * progress) : size.height, alignment: .top)
                    .background(.lotion)
                    /// Sticking it to top
                    .clipped()
                    .contentShape(.rect)
                    .offset(y: -minY)
                }
                .frame(height: calendarHeight)
                .zIndex(1000)
            }
        }
        
    }
}
