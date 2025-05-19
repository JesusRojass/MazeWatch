//
//  SeriesListView.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import SwiftUI

/// Main view showing a scrollable list of TV series with infinite scrolling and pull-to-refresh.
struct SeriesListView: View {
    @StateObject private var viewModel: SeriesListViewModel

    /// ViewModel must be injected to respect MVVM and allow testing/previews
    init(viewModel: SeriesListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(viewModel.series) { item in
                        NavigationLink(
                            destination: SeriesDetailView(
                                viewModel: SeriesDetailViewModel(
                                    seriesID: item.id,
                                    apiClient: AppEnvironment().apiClient
                                )
                            )
                        ) {
                            SeriesCardView(series: item)
                        }
                        .buttonStyle(.plain)
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

// MARK: - Previews
#if DEBUG
#Preview("Default") {
    SeriesListView(
        viewModel: SeriesListViewModel(apiClient: AppEnvironment().apiClient)
    )
}

#Preview("Empty state") {
    SeriesListView(
        viewModel: SeriesListViewModel(apiClient: PreviewAPIClientEmpty())
    )
}

#Preview("Loading state") {
    SeriesListView(
        viewModel: SeriesListViewModel(apiClient: PreviewAPIClientLoading())
    )
}

#if TEST
#Preview("With MockAPIClient") {
    SeriesListView(
        viewModel: SeriesListViewModel(apiClient: MockAPIClient())
    )
}
#endif

#endif
