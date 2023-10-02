//
//  Manager+Firebase.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 01/10/23.
//

import FirebaseCore
import Dependencies

extension Manager {
    struct Firebase {
        public var configure: @Sendable () -> Void
    }
}

extension Manager.Firebase: DependencyKey {
    public static let liveValue = Self(
        configure: { FirebaseApp.configure() }
    )
}

extension Manager.Firebase: TestDependencyKey {
    public static var previewValue = Self.noop
    
    public static let testValue = Self(
        configure: unimplemented("\(Self.self).configure")
    )
}

extension Manager.Firebase {
    static let noop = Self(
        configure: {}
    )
}
