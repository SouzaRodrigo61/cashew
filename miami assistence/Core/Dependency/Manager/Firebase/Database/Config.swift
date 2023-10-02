//
//  Manager+Firestore+Config.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 01/10/23.
//

extension Manager.FirestoreClient {
    struct Config: Codable, Equatable {
        let isMaintenance: Bool
        let minimumSupportedAppVersion: String
        
        init(isMaintenance: Bool, minimumSupportedAppVersion: String) {
            self.isMaintenance = isMaintenance
            self.minimumSupportedAppVersion = minimumSupportedAppVersion
        }
        
        func isForceUpdate(_ packageVersion: String) -> Bool {
            minimumSupportedAppVersion > packageVersion
        }
    }
}
