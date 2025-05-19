//
//  SeriesListViewModel.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation
import Combine

/// ViewModel for listing TV series with paginated loading and refresh support.
final class SeriesListViewModel: ObservableObject {
    @Published var series: [Series] = []
    @Published var isLoading = false
    @Published var currentPage = 0

    private let apiClient: APIClientProtocol
    private var cancellables = Set<AnyCancellable>()

    /// Cache for dividing large API responses into smaller UI-friendly chunks.
    private var chunkedCache: [[Series]] = []

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    /// Loads the next page or chunk of series into the UI.
    @MainActor
    func loadNextPage() async {
        guard !isLoading else { return }
        isLoading = true

        do {
            if chunkedCache.isEmpty {
                let rawPage = try await apiClient.fetchSeries(page: currentPage)
                chunkedCache = rawPage.chunked(into: 20)
                currentPage += 1
            }

            if let nextChunk = chunkedCache.first {
                series.append(contentsOf: nextChunk)
                chunkedCache.removeFirst()
            }
        } catch {
            print("Error loading series: \(error)")
        }

        isLoading = false
    }

    /// Resets pagination and reloads the first chunk.
    @MainActor
    func refresh() async {
        currentPage = 0
        series.removeAll()
        chunkedCache.removeAll()
        await loadNextPage()
    }
}
