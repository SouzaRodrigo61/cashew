//
//  CheckboxToggleStyle.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 25/08/23.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: 4)
                .frame(width: 25, height: 25)
                .cornerRadius(5.0)
                .overlay {
                    if configuration.isOn {
                        Image(systemName: "checkmark.square.fill")
                            .resizable()
                    }
                }
                .onTapGesture {
                    withAnimation(.smooth) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}

extension ToggleStyle where Self == CheckboxToggleStyle {
    static var checkmark: CheckboxToggleStyle {
        CheckboxToggleStyle()
    }
}
