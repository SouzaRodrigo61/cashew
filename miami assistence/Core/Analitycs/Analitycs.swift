//
//  Analitycs.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 28/07/23.
//

import Foundation
import FirebaseAnalytics

enum Analitycs {
    
    static func tracking(action: Main.Feature.Action, state: Main.Feature.State) {
        dump(action, name: "Action")
        dump(state.path, name: "State")
    }
}


// MARK: -  For study

@_silgen_name("swift_EnumCaseName")
func _getEnumCaseName<T>(_ value: T) -> UnsafePointer<CChar>?

func getEnumCaseName<T>(for value: T) -> String? {
   if let stringPtr = _getEnumCaseName(value) {
       return String(validatingUTF8: stringPtr)
   }
   return nil
}
