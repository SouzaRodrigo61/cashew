//
//  TextView.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 19/10/23.
//

import Foundation
import SwiftUI
import UIKit

struct UITextViewWrapper: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        do {
            let markdownAttString = try AttributedString(markdown: text)

            uiView.attributedText = NSAttributedString(markdownAttString)
        } catch {
            dump("Erro no parse")
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func textViewDidChange(_ textView: UITextView) {
            do {
                text = textView.text
                let markdownAttString = try AttributedString(markdown: textView.text)

                textView.attributedText = NSAttributedString(markdownAttString)
            } catch {
                dump("Erro no parse")
            }
        }
    }
}
