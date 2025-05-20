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
    @EnvironmentObject var router: AppRouter

    var body: some View {
        TabView(selection: $router.selectedTab) {
            SeriesListView(viewModel: SeriesListViewModel(apiClient: environment.apiClient))
                .tabItem {
                    Label("TV Series", systemImage: "tv")
                }
                .tag(AppRouter.Tab.series)
            
            PeopleSearchView()
                .tabItem {
                    Label("People", systemImage: "person.2")
                }
                .tag(AppRouter.Tab.peopleSearch)

            SearchView(viewModel: SearchViewModel(apiClient: environment.apiClient))
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(AppRouter.Tab.search)

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                .tag(AppRouter.Tab.favorites)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(AppRouter.Tab.settings)
        }
    }
}
