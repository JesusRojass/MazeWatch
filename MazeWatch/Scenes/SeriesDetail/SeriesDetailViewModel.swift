//
//  SeriesDetailViewModel.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation
import Combine

/// ViewModel responsible for loading and presenting detailed information about a TV series.
final class SeriesDetailViewModel: ObservableObject {
    @Published var series: SeriesDetail?
    @Published var episodesBySeason: [Int: [Episode]] = [:]
    @Published var isLoading: Bool = false
    @Published var error: Error?

    private let apiClient: APIClientProtocol
    private let seriesID: Int

    init(seriesID: Int, apiClient: APIClientProtocol) {
        self.seriesID = seriesID
        self.apiClient = apiClient
        loadData()
    }

    /// Loads the series details and episodes, grouping episodes by season.
    func loadData() {
        Task {
            await fetchSeriesDetail()
            await fetchEpisodes()
        }
    }

    @MainActor
    private func fetchSeriesDetail() async {
        isLoading = true
        do {
            series = try await apiClient.fetchSeriesDetail(id: seriesID)
        } catch {
            self.error = error
        }
        isLoading = false
    }

    @MainActor
    private func fetchEpisodes() async {
        do {
            let episodes = try await apiClient.fetchEpisodes(forSeriesID: seriesID)
            episodesBySeason = Dictionary(grouping: episodes, by: { $0.season })
        } catch {
            self.error = error
        }
    }
}
