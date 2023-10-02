//
//  KeyboardAdaptive.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 29/09/23.
//

import SwiftUI
import Combine

struct KeyboardAdaptive: ViewModifier {
    @State private var bottomPadding: CGFloat
    
    init(bottomPadding: CGFloat = 0) {
        self.bottomPadding = bottomPadding
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, self.bottomPadding)
                .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                    let keyboardTop = geometry.frame(in: .global).height - keyboardHeight
                    let focusedTextInputBottom = UIResponder.currentFirstResponder?.globalFrame?.maxY ?? 0
                    self.bottomPadding = max(0, focusedTextInputBottom - keyboardTop - geometry.safeAreaInsets.bottom)
                    
                    dump(bottomPadding, name: "bottomPadding")
            }
            .animation(.easeOut(duration: 0.16), value: bottomPadding)
        }
    }
}

extension View {
    func keyboardAdaptive(with bottomPadding: CGFloat = 0) -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive(bottomPadding: bottomPadding))
    }
}

extension UIResponder {
    static var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return _currentFirstResponder
    }

    private static weak var _currentFirstResponder: UIResponder?

    @objc private func findFirstResponder(_ sender: Any) {
        UIResponder._currentFirstResponder = self
    }

    var globalFrame: CGRect? {
        guard let view = self as? UIView else { return nil }
        return view.superview?.convert(view.frame, to: nil)
    }
}
