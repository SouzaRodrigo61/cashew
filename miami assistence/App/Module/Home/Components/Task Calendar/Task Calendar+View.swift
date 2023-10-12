//
//  Task Calendar+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 15/09/23.
//

import SwiftUI
import ComposableArchitecture
import UserNotifications
import CoreData

extension TaskCalendar {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            ZStack(alignment: .top) {
                
                IfLetStore(store.scope(state: \.task, action: Feature.Action.task)) {
                    Task.View(store: $0)
                }
                .offset(y: 120)
                
                IfLetStore(store.scope(state: \.header, action: Feature.Action.header)) {
                    Header.View(store: $0)
                }
            }
            .onAppear { store.send(.onAppear) }
            .overlay {
                IfLetStore(store.scope(state: \.taskCreate, action: Feature.Action.taskCreate)) {
                    TaskCreate.View(store: $0)
                }
                .background(.white)
                .transition(.move(edge: .top))
            }
            .onReceive(NotificationCenter.default.publisher(
                for: NSPersistentCloudKitContainer.eventChangedNotification
            ).receive(on: DispatchQueue.main)) { notification in
                guard let event = notification.userInfo?[NSPersistentCloudKitContainer.eventNotificationUserInfoKey] as? NSPersistentCloudKitContainer.Event else {
                    return
                }
                if event.endDate != nil && event.type == .import {
                    
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            let content = UNMutableNotificationContent()
                            content.title = "Nova tarefa"
                            content.subtitle = "Abra o app para visualizar o novo lancamento de tarefa"
                            content.sound = UNNotificationSound.default

                            // show this notification five seconds from now
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                            // choose a random identifier
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                            // add our notification request
                            UNUserNotificationCenter.current().add(request)
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                    

                    store.send(.onAppear)
                }
            }
        }
    }
}
