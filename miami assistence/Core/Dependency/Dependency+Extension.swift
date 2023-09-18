//
//  DependencyValues+Extension.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 16/09/23.
//

import Foundation
import Dependencies

extension DependencyValues {
    var storeManager: Manager.Store {
        get { self[Manager.Store.self] }
        set { self[Manager.Store.self] = newValue }
    }
    
    var userDefaults: Manager.UserDefaultsClient {
        get { self[Manager.UserDefaultsClient.self] }
        set { self[Manager.UserDefaultsClient.self] = newValue }
    }
    
    var store: Manager.StoreKit {
        get { self[Manager.StoreKit.self] }
        set { self[Manager.StoreKit.self] = newValue }
    }
    
    var analytics: Manager.Analitycs {
        get { self[Manager.Analitycs.self] }
        set { self[Manager.Analitycs.self] = newValue }
    }
}

