//
//  Manager+FirestoreClient.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 12/10/23.
//

import Dependencies

extension Manager {
    struct FirestoreClient {
//        static let db = Firestore.firestore()
        
        let config: @Sendable () async throws -> AsyncThrowingStream<Config, Error>
        let createTask: @Sendable (Task.Model) async throws -> Void
        let updateNote: @Sendable (Task.Model) async throws -> Void
        let task: @Sendable () async throws -> AsyncThrowingStream<[Task.Model], Error>
        
        enum ManagerFireStoreClientError: Error {
            case runtimeError(String)
        }
        
        enum ClientCollection: String {
            case config = "config"
            case task = "task"
        }
    }
}

extension Manager.FirestoreClient: DependencyKey {
    static let liveValue: Self = .init(
        config: {
            AsyncThrowingStream { continuation in
//                let listener = db.collection("config").document("global")
//                    .addSnapshotListener { documentSnapshot, error in
//                        if let error {
//                            continuation.finish(throwing: error)
//                        }
//                        if let documentSnapshot, documentSnapshot.exists {
//                            do {
//                                try continuation.yield(documentSnapshot.data(as: Config.self))
//                            } catch {
//                                continuation.finish(throwing: error)
//                            }
//                        }
//                    }
//                continuation.onTermination = { @Sendable _ in
//                    listener.remove()
//                }
            }
        },
        createTask: { model in
//            do {
//                try db.collection("task").document(model.id.uuidString).setData(from: model)
//            } catch let error {
//                throw ManagerFireStoreClientError.runtimeError(error.localizedDescription)
//            }
        },
        updateNote: { model in
//            do {
//                try db.collection("task")
//                    .document(model.id.uuidString)
//                    .setData(from: model, merge: true)
//            } catch let error {
//                throw ManagerFireStoreClientError.runtimeError(error.localizedDescription)
//            }
        },
        task: {
            AsyncThrowingStream { continuation in
//                let listener = db.collection("task")
//                    .addSnapshotListener { documentSnapshot, error in
//                        if let error {
//                            continuation.finish(throwing: error)
//                        }
//                        if let documentSnapshot {
//                            continuation.yield(
//                                documentSnapshot.documents.compactMap { query -> Task.Model? in
//                                    try? query.data(as: Task.Model.self)
//                                }
//                            )
//                        }
//                    }
//                continuation.onTermination = { @Sendable _ in
//                    listener.remove()
//                }
            }
        }
    )
}


extension Manager.FirestoreClient: TestDependencyKey {
    static let testValue = Self(
        config: unimplemented("\(Self.self).config"),
        createTask: unimplemented("\(Self.self).createTask"),
        updateNote: unimplemented("\(Self.self).updateNote"),
        task: unimplemented("\(Self.self).task")
    )
}
