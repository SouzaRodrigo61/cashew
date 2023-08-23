//
//  OffsettableScrollView.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 21/08/23.
//

import SwiftUI
import ComposableArchitecture

struct Refreshable {
    struct Feature: Reducer {
        struct State: Equatable {
            var refreshHeight: CGFloat
            var progress: CGFloat = 0
            var isScroll: Bool = false
            var isRefreshing: Bool = false
            var contentOffset: CGFloat = 0
        }
        
        enum Action: Equatable {
            case contentOffsetGetted(CGFloat)
            case progressSetted(CGFloat)
            case refreshActived
            
            case scrollViewDidEndDecelerating
            case scrollViewWillEndDragging(CGPoint)
            case scrollViewWillBeginDecelerating
            
            case scrollViewWillBeginDragging
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}

struct RefreshableScrollView<T: View, R: View>: View {
    let store: StoreOf<Refreshable.Feature>
    
    let axes: Axis.Set
    let showsIndicator: Bool
    let content: T
    let refresh: R
    
    @State private var scrollOffset: CGFloat = 0
    @State private var contentOffset: CGFloat = 0
    
    init(axes: Axis.Set = .vertical,
         showsIndicator: Bool = true,
         store: StoreOf<Refreshable.Feature>,
         @ViewBuilder content: @escaping () -> T,
         @ViewBuilder refresh: @escaping () -> R
    ) {
        self.axes = axes
        self.showsIndicator = showsIndicator
        self.content = content()
        self.refresh = refresh()
        self.store = store
    }
    
    var body: some View {
        GeometryReader { geo in
            WithViewStore(store, observe: { $0 } ) { viewStore in
                ScrollViewReader { scrollProxy in
                    ScrollView(axes) {
                        
                        ZStack(alignment: .top) {
                            refresh
                                .offset(y: viewStore.state.isRefreshing
                                            ? -(contentOffset < 0 ? 0 : contentOffset)
                                            : viewStore.state.isScroll
                                                ? -(contentOffset < 0 ? 0 : contentOffset)
                                                : -100)
                            
                            
                            VStack {
                                if viewStore.isRefreshing {
                                    Spacer(minLength: viewStore.refreshHeight)
                                }
                                
                                content
                            }
                        }
                        .background { ScrollViewDetector(store: store) }
                        .background {
                            GeometryReader { geometry in
                                Color.clear
                                    .preference(key: ScrollOffsetPreferenceKey.self,
                                                value: geometry.frame(in: .named("SCROLL")).origin)
                            }
                        }
                        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                            contentOffset = value.y
                            
                            if !viewStore.state.isRefreshing {
                                if value.y > 0 {
                                    scrollOffset = value.y
                                    store.send(.contentOffsetGetted(value.y))
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .coordinateSpace(name: "SCROLL")
                }
            }
        }
        
    }
}

fileprivate struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}
