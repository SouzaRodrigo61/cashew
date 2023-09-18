//
//  Manager+UserDefaults.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 17/09/23.
//

import Foundation
import Dependencies

extension Manager {
    struct UserDefaultsClient {
        public var boolForKey: @Sendable (String) -> Bool
        public var dataForKey: @Sendable (String) -> Data?
        public var doubleForKey: @Sendable (String) -> Double
        public var integerForKey: @Sendable (String) -> Int
        public var stringForKey: @Sendable (String) -> String?
        public var remove: @Sendable (String) async -> Void
        public var setBool: @Sendable (Bool, String) async -> Void
        public var setData: @Sendable (Data?, String) async -> Void
        public var setDouble: @Sendable (Double, String) async -> Void
        public var setInteger: @Sendable (Int, String) async -> Void
        public var setString: @Sendable (String, String) async -> Void
    }
}

extension Manager.UserDefaultsClient {
    func setCodable(_ value: Codable, forKey key: String) async {
        let data = try? encoder.encode(value)
        return await setData(data, key)
    }
    
    func codableForKey<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = dataForKey(key) else { return nil }
        return try? decoder.decode(T.self, from: data)
    }
    
    func setPhoneNumber(_ value: String) async {
        await setString(value, keyPhoneNumber)
    }
    
    func phoneNumber() -> String? {
        stringForKey(keyPhoneNumber)
    }
    
    func setVerificationId(_ value: String) async {
        await setString(value, keyVerificationId)
    }
    
    func verificationId() -> String? {
        stringForKey(keyVerificationId)
    }
    
    func setOnboardCompleted(_ value: Bool) async {
        await setBool(value, keyOnboardCompleted)
    }
    
    func onboardCompleted() -> Bool {
        boolForKey(keyOnboardCompleted)
    }
}

private let keyPhoneNumber = "PHONE_NUMBER"
private let keyVerificationId = "VERIFICATION_ID"
private let keyOnboardCompleted = "ONBOARD_COMPLETED"

private let decoder = JSONDecoder()
private let encoder = JSONEncoder()


extension Manager.UserDefaultsClient: DependencyKey {
    public static let liveValue: Self = {
        let appGroup = Bundle.main.infoDictionary?["AppGroup"] as? String
        let suiteName = appGroup ?? "group.com.caaaption-staging"
        print("suiteName : \(suiteName)")
        return Self.live(suiteName: suiteName)
    }()
    
    private static func live(suiteName: String) -> Self {
        let defaults = { UserDefaults(suiteName: suiteName)! }
        
        return Self(
            boolForKey: { defaults().bool(forKey: $0) },
            dataForKey: { defaults().data(forKey: $0) },
            doubleForKey: { defaults().double(forKey: $0) },
            integerForKey: { defaults().integer(forKey: $0) },
            stringForKey: { defaults().string(forKey: $0) },
            remove: { defaults().removeObject(forKey: $0) },
            setBool: { defaults().set($0, forKey: $1) },
            setData: { defaults().set($0, forKey: $1) },
            setDouble: { defaults().set($0, forKey: $1) },
            setInteger: { defaults().set($0, forKey: $1) },
            setString: { defaults().set($0, forKey: $1) }
        )
    }
    
    public static let previewValue = Self.noop
    
    public static let testValue = Self(
        boolForKey: unimplemented("\(Self.self).boolForKey", placeholder: false),
        dataForKey: unimplemented("\(Self.self).dataForKey", placeholder: nil),
        doubleForKey: unimplemented("\(Self.self).doubleForKey", placeholder: 0),
        integerForKey: unimplemented("\(Self.self).integerForKey", placeholder: 0),
        stringForKey: unimplemented("\(Self.self).stringForKey"),
        remove: unimplemented("\(Self.self).remove"),
        setBool: unimplemented("\(Self.self).setBool"),
        setData: unimplemented("\(Self.self).setData"),
        setDouble: unimplemented("\(Self.self).setDouble"),
        setInteger: unimplemented("\(Self.self).setInteger"),
        setString: unimplemented("\(Self.self).setString")
    )
    
    static let noop = Self(
        boolForKey: { _ in false },
        dataForKey: { _ in nil },
        doubleForKey: { _ in 0 },
        integerForKey: { _ in 0 },
        stringForKey: { _ in nil },
        remove: { _ in },
        setBool: { _, _ in },
        setData: { _, _ in },
        setDouble: { _, _ in },
        setInteger: { _, _ in },
        setString: { _, _ in }
    )
}
