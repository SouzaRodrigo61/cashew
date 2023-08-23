//
//  ScrollViewDetector.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 22/08/23.
//

import ComposableArchitecture
import SwiftUI

struct ScrollViewDetector: UIViewRepresentable {
    let store: StoreOf<Refreshable.Feature>
    
    init(store: StoreOf<Refreshable.Feature>) {
        self.store = store
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, store: store)
    }
    
    func makeUIView(context: Context) -> UIView {
        UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            if let scrollView = uiView.superview?.superview?.superview as? UIScrollView {
                scrollView.delegate = context.coordinator
            }
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        private var parent: ScrollViewDetector
        private var velocityY: CGFloat = 0
        
        let store: StoreOf<Refreshable.Feature>
        
        init(parent: ScrollViewDetector, store: StoreOf<Refreshable.Feature>) {
            self.parent = parent
            self.store = store
        }
                
        func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
            store.send(.scrollViewWillBeginDecelerating, animation: .default)
        }
        
        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            store.send(.scrollViewWillBeginDragging, animation: .default)
        }
    }
}
