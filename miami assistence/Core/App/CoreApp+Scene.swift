//
//  CoreApp+Scene.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 17/09/23.
//

import SwiftUI
import ComposableArchitecture

extension CoreApp {
    class Scene: UIResponder, UIWindowSceneDelegate {
        func windowScene(
            _ windowScene: UIWindowScene,
            performActionFor shortcutItem: UIApplicationShortcutItem,
            completionHandler: @escaping (Bool) -> Void
        ) {
//            Delegate.shared.store.send(.shortcutItem(shortcutItem))
            completionHandler(true)
        }
    }
}
