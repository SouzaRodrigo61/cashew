//
//  Analitycs.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 28/07/23.
//

import Foundation

enum Analitycs {}


// MARK: -  For study

@_silgen_name("swift_EnumCaseName")
func _getEnumCaseName<T>(_ value: T) -> UnsafePointer<CChar>?

func getEnumCaseName<T>(for value: T) -> String? {
   if let stringPtr = _getEnumCaseName(value) {
       return String(validatingUTF8: stringPtr)
   }
   return nil
}
