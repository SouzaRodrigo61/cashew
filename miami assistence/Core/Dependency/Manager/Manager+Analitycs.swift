//
//  Analitycs.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 28/07/23.
//

import Foundation
import Dependencies

extension Manager {
    struct Analitycs {
        public var logEvent: @Sendable (LogEvent) -> Void
        public var setUserId: @Sendable (String) -> Void
        public var setUserProperty: @Sendable (UserProperty) -> Void
        public var setAnalyticsCollectionEnabled: @Sendable (Bool) -> Void
        
        public typealias LogEvent = (String, parameters: [String: Any]?)
        public typealias UserProperty = (value: String?, forName: String)
    }
}

extension Manager.Analitycs: DependencyKey {
    public static let liveValue = Self(
        logEvent: unimplemented("\(Self.self).logEvent"),
        setUserId: unimplemented("\(Self.self).setUserId"),
        setUserProperty: unimplemented("\(Self.self).setUserProperty"),
        setAnalyticsCollectionEnabled: unimplemented("\(Self.self).setAnalyticsCollectionEnabled")
    )
    
    public static let previewValue = Self.noop
    
    public static let testValue = Self(
        logEvent: unimplemented("\(Self.self).logEvent"),
        setUserId: unimplemented("\(Self.self).setUserId"),
        setUserProperty: unimplemented("\(Self.self).setUserProperty"),
        setAnalyticsCollectionEnabled: unimplemented("\(Self.self).setAnalyticsCollectionEnabled")
    )
}

extension Manager.Analitycs {
    static let noop = Self(
        logEvent: { _, _ in },
        setUserId: { _ in },
        setUserProperty: { _ in },
        setAnalyticsCollectionEnabled: { _ in }
    )
    static let consoleLogger = Self(
        logEvent: { name, parameters in
            print("""
      Analytics: \(name)
      \(parameters ?? [:])
      """)
        },
        setUserId: { print("\(Self.self).setUserId: \($0)") },
        setUserProperty: { print("\(Self.self).setUserProperty: \($0)") },
        setAnalyticsCollectionEnabled: { print("\(Self.self).setAnalyticsCollectionEnabled: \($0)") }
    )
}
