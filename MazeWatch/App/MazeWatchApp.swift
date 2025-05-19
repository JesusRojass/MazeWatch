//
//  MazeWatchApp.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import SwiftUI

@main
struct MazeWatchApp: App {
    @StateObject private var environment = AppEnvironment()
    @StateObject private var router = AppRouter()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(environment)
                .environmentObject(router)
        }
    }
}
