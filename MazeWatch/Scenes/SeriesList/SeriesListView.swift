//
//  SeriesListView.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import SwiftUI

/// Main view showing a scrollable list of TV series with infinite scrolling and pull-to-refresh.
struct SeriesListView: View {
    @EnvironmentObject var env: AppEnvironment
    @StateObject private var viewModel: SeriesListViewModel

    init() {
        _viewModel = StateObject(wrappedValue: SeriesListViewModel(apiClient: APIClient(baseURL: "https://api.tvmaze.com")))
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(viewModel.series) { item in
                        SeriesCardView(series: item)
                            .onAppear {
                                Task {
                                    if shouldTriggerNextPage(for: item) {
                                        await viewModel.loadNextPage()
                                    }
                                }
                            }
                    }

                    if viewModel.isLoading {
                        ProgressView("Loading more...")
                            .padding()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .refreshable {
                await viewModel.refresh()
            }
            .navigationTitle("TV Series")
            .task {
                await viewModel.loadNextPage()
            }
        }
    }

    /// Determines when to trigger loading the next page (5 items before the end).
    private func shouldTriggerNextPage(for item: Series) -> Bool {
        guard let index = viewModel.series.firstIndex(where: { $0.id == item.id }) else {
            return false
        }
        let threshold = viewModel.series.index(viewModel.series.endIndex, offsetBy: -5, limitedBy: viewModel.series.startIndex) ?? 0
        return index >= threshold
    }
}

/// Preview code, we can switch it depending of the environment
#if DEBUG
import SwiftUI

// Default app data (live API client)
#Preview("Default") {
    SeriesListView()
        .environmentObject(AppEnvironment())
}

// Simulated empty response
#Preview("Empty state") {
    SeriesListView()
        .environmentObject(AppEnvironment(apiClient: PreviewAPIClientEmpty()))
}

// Simulated loading delay
#Preview("Loading state") {
    SeriesListView()
        .environmentObject(AppEnvironment(apiClient: PreviewAPIClientLoading()))
}

#if TEST
// Unit test preview using mock client
#Preview("With MockAPIClient") {
    SeriesListView()
        .environmentObject(AppEnvironment(apiClient: MockAPIClient()))
}
#endif

#endif
