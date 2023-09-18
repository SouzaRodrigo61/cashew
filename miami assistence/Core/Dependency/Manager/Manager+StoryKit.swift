//
//  Manager+StoryKit.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 17/09/23.
//

import Foundation
import Dependencies
import StoreKit


extension Manager {
    struct StoreKit {
        public var miamiAssistenceId: @Sendable () -> String
        public var revealId: @Sendable () -> String
        public var transactionUpdates: @Sendable () -> Transaction.Transactions
        public var products: @Sendable ([String]) async throws -> [Product]
        public var purchase: @Sendable (Product) async throws -> Product.PurchaseResult
    }
}


extension Manager.StoreKit: DependencyKey {
    public static let liveValue = Self(
        miamiAssistenceId: { "io.souzarodrigo.miami-assistence.miami-assistence.default" },
        revealId: { "io.souzarodrigo.miami-assistence.reveal_poll" },
        transactionUpdates: { Transaction.updates },
        products: { try await Product.products(for: $0) },
        purchase: { try await $0.purchase() }
    )
    
    public static let testValue = Self(
        miamiAssistenceId: unimplemented("\(Self.self).godModeId"),
        revealId: unimplemented("\(Self.self).revealId"),
        transactionUpdates: unimplemented("\(Self.self).transactionUpdates"),
        products: unimplemented("\(Self.self).products"),
        purchase: unimplemented("\(Self.self).purchase")
    )
}
