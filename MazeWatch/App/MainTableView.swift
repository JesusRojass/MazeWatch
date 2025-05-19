//
//  MainTableView.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import SwiftUI

/// Main app entry point containing tab-based navigation for TV Series, Search, and Favorites.
struct MainTabView: View {
    @EnvironmentObject var environment: AppEnvironment

    var body: some View {
        TabView {
            SeriesListView(viewModel: SeriesListViewModel(apiClient: environment.apiClient))
                .tabItem {
                    Label("TV Series", systemImage: "tv")
                }

            SearchView(viewModel: SearchViewModel(apiClient: environment.apiClient))
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
        }
    }
}

// MARK: - FavoritesView.swift

import SwiftUI

/// Placeholder view for user favorites. Prepared for future functionality.
struct FavoritesView: View {
    var body: some View {
        NavigationView {
            Text("Your favorite shows")
                .navigationTitle("Favorites")
        }
    }
}
