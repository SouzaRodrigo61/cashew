//
//  DependencyValues+Extension.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 16/09/23.
//

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
    
    var modelContext: Manager.SwiftDataClient {
        get { self[Manager.SwiftDataClient.self] }
        set { self[Manager.SwiftDataClient.self] = newValue }
    }
    
    var modelTask: Manager.SwiftDataClient.TaskDatabase {
        get { self[Manager.SwiftDataClient.TaskDatabase.self] }
        set { self[Manager.SwiftDataClient.TaskDatabase.self] = newValue }
    }
}

