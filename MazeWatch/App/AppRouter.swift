//
//  AppRouter.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation
import Combine

/// Centralized app routing logic for managing main tab navigation.
final class AppRouter: ObservableObject {
    enum Tab: Hashable {
        case series
        case search
        case favorites
        case settings
    }

    @Published var selectedTab: Tab = .series
}
