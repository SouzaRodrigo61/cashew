//
//  HomeModel.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 21/06/23.
//

import Foundation

struct Patient: Identifiable {
    let id = UUID().uuidString
    let name: String
    let contact: [Contact]

    struct Contact {
        let method: Method

        enum Method {
            case phone(String)
            case whatsapp(String)
            case instagram(String)
        }
    }
}

///
/// Anamnese
///
///      Fotos Faciais ( min: 3 )
///      Fotos Corporarais ( min: 4 )
///
///
///
