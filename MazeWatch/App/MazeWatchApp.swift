//
//  MazeWatchApp.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import SwiftUI

@main
struct MazeWatchApp: App {
    @StateObject private var router = AppRouter()

    var body: some Scene {
        WindowGroup {
            switch router.currentRoute {
            case .lock:
                LockScreenView {
                    router.currentRoute = .mainTabs
                }
            case .mainTabs:
                MainTabView()
                    .environmentObject(AppEnvironment())
                    .environmentObject(router)
            }
        }
    }
}
