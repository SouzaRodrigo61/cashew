//
//  String+Extension.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 22/06/23.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)")
    }

    ///
    /// This function serves to add arguments needed for custom string handling and localization.
    ///
    ///     Text("by_user".localized(args: "Rodrigo", "Abestado"))
    ///          .font(.system(size: 40))
    ///
    ///
    func localized(args: CVarArg...) -> String {
        return String(format: localized, arguments: args)
    }
}
