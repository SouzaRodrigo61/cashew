//
//  OffsettableScrollView.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 21/08/23.
//

import SwiftUI
import ComposableArchitecture

struct OffsettableScrollView<T: View>: View {
    
    struct Feature: Reducer {
        struct State: Equatable {
            var task: Task.Model?
        }
        
        enum Action: Equatable {
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
    
    let axes: Axis.Set
    let showsIndicator: Bool
    
    let content: T
    
    let onRefresh: () async -> ()
    
    @ObservedObject var scrollDelegate: ScrollViewModel = .init()
    
    init(axes: Axis.Set = .vertical,
         showsIndicator: Bool = true,
         @ViewBuilder content: () -> T,
         onRefresh: @escaping () async -> ()
    ) {
        self.axes = axes
        self.showsIndicator = showsIndicator
        self.content = content()
        self.onRefresh = onRefresh
    }
    
    var body: some View {
        ScrollView(axes) {
            ZStack(alignment: .top) {
                Text("geo.size.height")
                    .foregroundStyle(.dark)
                //                        .opacity(scrollDelegate.isEligible ? 1 : 0)
                //                        .scaleEffect(scrollDelegate.isEligible ? 1 : 0.001)
                    .frame(maxWidth: .infinity)
                    .frame(height: 150 * scrollDelegate.progress)
                    .background(.blue)
                    .opacity(scrollDelegate.progress)
                    .offset(y: scrollDelegate.isEligible ? -(scrollDelegate.contentOffset < 0 ? 0 : scrollDelegate.contentOffset) : -( scrollDelegate.scrollOffset < 0 ? 0 : scrollDelegate.scrollOffset ))
                
                
                content
            }            
            .offset(coordinateSpace: "SCROLL") { value in
                scrollDelegate.contentOffset = value
                
                if !scrollDelegate.isEligible {
                    var progress = value / 150
                    progress = (progress < 0 ? 0 : progress)
                    progress = (progress > 1 ? 1 : progress)
                    
                    scrollDelegate.scrollOffset = value
                    scrollDelegate.progress = progress
                }
                
                if scrollDelegate.isEligible && !scrollDelegate.isRefreshing {
                    scrollDelegate.isRefreshing = true
                    
                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                }
            }
        }
        .coordinateSpace(name: "SCROLL")
        .onAppear(perform: scrollDelegate.addGesture)
        .onDisappear(perform: scrollDelegate.removeGesture)
        .onChange(of: scrollDelegate.isRefreshing) { oldValue, newValue in
            if newValue {
                SwiftUI.Task {
                    await onRefresh()
                    
                    withAnimation {
                        scrollDelegate.progress = 0
                        scrollDelegate.scrollOffset = 0
                        scrollDelegate.isEligible = false
                        scrollDelegate.isRefreshing = false
                    }
                }
            }
        }
    }
}

class ScrollViewModel: NSObject, ObservableObject, UIGestureRecognizerDelegate {
    @Published var isEligible: Bool = false
    @Published var isRefreshing: Bool = false
    @Published var scrollOffset: CGFloat = 0
    @Published var progress: CGFloat = 0
    @Published var contentOffset: CGFloat = 0
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func addGesture() {
        let penGesture = UIPanGestureRecognizer(target: self, action: #selector(onGestureChange(gesture:)))
        penGesture.delegate = self
        
        rootController().view.addGestureRecognizer(penGesture)
    }
    
    func removeGesture() {
        rootController().view.gestureRecognizers?.removeAll()
    }
    
    func rootController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .init() }
        guard let root = screen.windows.first?.rootViewController else { return .init() }
        
        return root
    }
    
    @objc func onGestureChange(gesture: UIPanGestureRecognizer) {
        if gesture.state == .cancelled || gesture.state == .ended {
            if scrollOffset > 150 {
                isEligible = true
            } else {
                isEligible = false
            }
        }
    }
}
