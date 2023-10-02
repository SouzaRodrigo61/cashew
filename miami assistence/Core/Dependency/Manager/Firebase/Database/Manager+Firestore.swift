//
//  Manager+Data.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 01/10/23.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Dependencies

extension Manager {
    struct FirestoreClient {
        public var config: () async throws -> AsyncThrowingStream<Config, Error>
    }
}

extension Manager.FirestoreClient {
    enum LocalError: Error {
        case documentNotExist
    }
}

extension Manager.FirestoreClient: DependencyKey {
    static let liveValue: Self = .init(
        config: {
            AsyncThrowingStream { continuation in
                let db = Firestore.firestore()
        
                let listener = db.collection("config").document("global")
                    .addSnapshotListener { documentSnapshot, error in
                        if let error {
                            continuation.finish(throwing: error)
                        }
                        if let documentSnapshot, documentSnapshot.exists {
                            do {
                                try continuation.yield(documentSnapshot.data(as: Config.self))
                            } catch {
                                continuation.finish(throwing: error)
                            }
                        }
                    }
                continuation.onTermination = { @Sendable _ in
                    listener.remove()
                }
            }
        }
    )
}


extension Manager.FirestoreClient: TestDependencyKey {
    static let testValue = Self(
        config: unimplemented("\(Self.self).config")
    )
}
