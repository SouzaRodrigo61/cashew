//
//  Manager+SwiftData+Task.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 08/10/23.
//

import Foundation
import SwiftData
import Dependencies

extension Manager.SwiftDataClient {
    struct TaskDatabase {
        var fetch: @Sendable () throws -> [Task.Model]
        var add: @Sendable (Task.Model) throws -> Void
        var delete: @Sendable (Task.Model) throws -> Void
        
        enum TaskError: Error {
            case add
            case delete
        }
    }
}

extension Manager.SwiftDataClient.TaskDatabase: DependencyKey {
    public static let liveValue = Self(
        fetch: {
            do {
                @Dependency(\.modelContext.context) var context
                let movieContext = try context()
                
                let descriptor = FetchDescriptor<Task.Model>()
                return try movieContext.fetch(descriptor)
            } catch {
                return []
            }
        },
        add: { model in
            do {
                @Dependency(\.modelContext.context) var context
                let movieContext = try context()
                
                movieContext.insert(model)
                
                try movieContext.save()
            } catch {
                throw TaskError.add
            }
        },
        delete: { model in
            do {
                @Dependency(\.modelContext.context) var context
                let movieContext = try context()
                
                let modelToBeDelete = model
                movieContext.delete(modelToBeDelete)
                
                try movieContext.save()
            } catch {
                throw TaskError.delete
            }
        }
    )
}

extension Manager.SwiftDataClient.TaskDatabase: TestDependencyKey {
    public static var previewValue = Self.noop
    
    public static let testValue = Self(
        fetch: unimplemented("\(Self.self).fetch"),
        add: unimplemented("\(Self.self).add"),
        delete: unimplemented("\(Self.self).delete")
    )
    
    static let noop = Self(
        fetch: { [] },
        add: { _ in },
        delete: { _ in }
    )
}
