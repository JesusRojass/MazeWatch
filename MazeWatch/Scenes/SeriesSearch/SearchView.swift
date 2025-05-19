//
//  SearchView.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import SwiftUI

/// Search screen allowing users to find TV series by name.
struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel

    /// ViewModel must be injected to respect MVVM and allow testing/previews
    init(viewModel: SearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            Group {
                if viewModel.query.isEmpty {
                    emptyStateView(icon: "magnifyingglass", message: "Start searching for TV shows")
                } else if viewModel.isLoading {
                    loadingStateView()
                } else if viewModel.results.isEmpty {
                    emptyStateView(icon: "questionmark.circle", message: "Sorry, no results found")
                } else {
                    searchResultsList
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

    private var searchResultsList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.results) { series in
                    NavigationLink(destination: detailView(for: series)) {
                        SeriesCardView(series: series)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal)
                }
            }
        }
        .background(Color(UIColor.systemBackground))
    }

    private func detailView(for series: Series) -> some View {
        SeriesDetailView(
            viewModel: SeriesDetailViewModel(
                seriesID: series.id,
                apiClient: viewModel.apiClient
            )
        )
    }

    private func emptyStateView(icon: String, message: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            Text(message)
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func loadingStateView() -> some View {
        VStack(spacing: 12) {
            ProgressView("Searching...")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#if DEBUG
#Preview("Default") {
    SearchView(
        viewModel: SearchViewModel(apiClient: AppEnvironment().apiClient)
    )
}

#Preview("Empty state") {
    SearchView(
        viewModel: SearchViewModel(apiClient: PreviewAPIClientEmpty())
    )
}

#Preview("Loading state") {
    SearchView(
        viewModel: SearchViewModel(apiClient: PreviewAPIClientLoading())
    )
}

#if TEST
#Preview("With MockAPIClient") {
    SearchView(
        viewModel: SearchViewModel(apiClient: MockAPIClient())
    )
}
#endif
#endif
