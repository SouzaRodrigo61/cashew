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
            var scrollOffset: CGFloat = 0
        }
        
        enum Action: Equatable {
            case contentOffsetGetted(CGFloat)
            case progressSetted(CGFloat)
            case refreshActived
            
            case dragged(CGFloat)
            case scrollOffset(CGFloat)
            
            case scrollViewDidEndDecelerating
            case scrollViewWillEndDragging(CGPoint)
            case scrollViewWillBeginDecelerating
            
            case scrollViewWillBeginDragging
        }
        
        var body: some Reducer<State, Action> {
            Reduce { state, action in
                switch action {
                case let .dragged(value):
                    state.scrollOffset = value
                    return .none
                default:
                    return .none
                }
            }
        }
    }
}

struct RefreshableScrollView<T: View, R: View>: View {
    let store: StoreOf<Refreshable.Feature>
    
    let axes: Axis.Set
    let showsIndicator: ScrollIndicatorVisibility
    let content: T
    let refresh: R
    
    @State private var contentHeight: CGFloat = 0
    
    init(axes: Axis.Set = .vertical,
         showsIndicator: ScrollIndicatorVisibility = .automatic,
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
        GeometryReader { metrics in
            WithViewStore(store, observe: { $0 } ) { viewStore in
                ScrollView(axes) {
                    ZStack(alignment: .top) {
                        refresh
                            .frame(height: viewStore.refreshHeight * viewStore.progress, alignment: .bottom)
                            .opacity(viewStore.isScroll ? 1 : viewStore.isRefreshing ? 1 : 0)
                            .opacity(viewStore.progress)
                            .offset(y: viewStore.isRefreshing ? 0 : -(viewStore.contentOffset))
                        
                        content
                            .offset(y: viewStore.isRefreshing
                                    ? viewStore.refreshHeight + 8
                                    : viewStore.isScroll ? 8 : 0)
                            .frame(minHeight: metrics.size.height, alignment: .top)
                        
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
                        store.send(.scrollOffset(value.y))
                        
                        if !viewStore.isRefreshing {
                            if value.y > 0 {
                                store.send(.contentOffsetGetted(value.y))
                            }
                        }
                    }
                }
                .padding(.top, 1)
                .scrollDismissesKeyboard(.interactively)
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .scrollIndicators(showsIndicator)
                .coordinateSpace(name: "SCROLL")
            }
        }
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}

extension ScrollView {
    
    public func fixFlickering() -> some View {
        
        return self.fixFlickering { (scrollView) in
            
            return scrollView
        }
    }
    
    public func fixFlickering<T: View>(@ViewBuilder configurator: @escaping (ScrollView<AnyView>) -> T) -> some View {
        
        GeometryReader { geometryWithSafeArea in
            GeometryReader { geometry in
                configurator(
                ScrollView<AnyView>(self.axes, showsIndicators: self.showsIndicators) {
                    AnyView(
                    VStack {
                        self.content
                    }
                    .padding(.top, geometryWithSafeArea.safeAreaInsets.top)
                    .padding(.bottom, geometryWithSafeArea.safeAreaInsets.bottom)
                    .padding(.leading, geometryWithSafeArea.safeAreaInsets.leading)
                    .padding(.trailing, geometryWithSafeArea.safeAreaInsets.trailing)
                    )
                }
                )
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
