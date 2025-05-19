//
//  SearchView.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import SwiftUI

/// Search screen allowing users to find TV series by name.
struct SearchView: View {
    @EnvironmentObject var env: AppEnvironment
    @StateObject private var viewModel: SearchViewModel

    init() {
        _viewModel = StateObject(wrappedValue: SearchViewModel(apiClient: APIClient(baseURL: "https://api.tvmaze.com")))
    }

    var body: some View {
        NavigationView {
            Group {
                if viewModel.query.isEmpty {
                    // Placeholder state before user starts typing
                    VStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 48))
                            .foregroundColor(.secondary)
                        Text("Start searching for TV shows")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.isLoading {
                    // Loading indicator during search
                    VStack(spacing: 12) {
                        ProgressView("Searching...")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.results.isEmpty {
                    // No results found state
                    VStack(spacing: 12) {
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: 48))
                            .foregroundColor(.secondary)
                        Text("Sorry, no results found")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    // Display search results as a list of cards
                    List {
                        ForEach(viewModel.results) { series in
                            SeriesCardView(series: series)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(Color(UIColor.systemBackground))
                }
            }
            .searchable(text: $viewModel.query)
            .submitLabel(.search)
            .onSubmit {
                hideKeyboard()
            }
            .navigationTitle("Search")
        }
    }
}
