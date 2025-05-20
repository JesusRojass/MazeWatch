//
//  AppRouter.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation
import Combine

/// Centralized app routing logic for managing global navigation and main tab state.
final class AppRouter: ObservableObject {
    enum AppRoute: Hashable {
        case lock
        case mainTabs
    }

    enum Tab: Hashable {
        case series
        case peopleSearch 
        case search
        case favorites
        case settings
    }

    @Published var currentRoute: AppRoute
    @Published var selectedTab: Tab = .series

    init() {
        let hasPIN = !(UserDefaults.standard.string(forKey: "userPIN") ?? "").isEmpty
        currentRoute = hasPIN ? .lock : .mainTabs
    }
}
