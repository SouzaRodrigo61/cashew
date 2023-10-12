//
//  Manager+SwiftData.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 08/10/23.
//

import Foundation
import Dependencies
import SwiftData

extension Manager {
    struct SwiftDataClient {
        var context: () throws -> ModelContext
    }
}

extension Manager.SwiftDataClient: DependencyKey {
    static let appContext: ModelContext = {
        do {
            let schema = Schema([Task.Model.self])
            
            let config = ModelConfiguration(schema: schema)
            let container = try ModelContainer(for: schema, configurations: config)
            return ModelContext(container)
        } catch {
            fatalError("Failed to create container.")
        }
    }()
    
    public static let liveValue = Self(
        context: { appContext }
    )

    public static var previewValue = Self.noop
    
    public static let testValue = Self(
        context: unimplemented("\(Self.self).context")
    )
    
    static let noop = Self(
        context: unimplemented("\(Self.self).context")
    )
}
