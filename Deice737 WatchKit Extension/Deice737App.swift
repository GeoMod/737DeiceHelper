//
//  Deice737App.swift
//  Deice737 WatchKit Extension
//
//  Created by Daniel O'Leary on 2/3/21.
//

import SwiftUI

@main
struct Deice737App: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
