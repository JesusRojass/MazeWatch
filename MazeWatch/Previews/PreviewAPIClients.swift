//
//  PreviewAPIClients.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation

/// Simulates an API client that returns an empty list of series for preview purposes.
final class PreviewAPIClientEmpty: APIClientProtocol {
    func fetchSeries(page: Int) async throws -> [Series] { [] }
    func searchSeries(query: String) async throws -> [Series] { [] }
    func fetchSeriesDetail(id: Int) async throws -> SeriesDetail { throw APIError.notFound }
    func fetchEpisodes(forSeriesID id: Int) async throws -> [Episode] { [] }
    func fetchPeople(page: Int) async throws -> [Person] { [] }
    func fetchPersonCredits(personID: Int) async throws -> [CastCredit] { [] }
}

/// Simulates an API client that mimics a delayed loading state in previews.
final class PreviewAPIClientLoading: APIClientProtocol {
    func fetchSeries(page: Int) async throws -> [Series] {
        try await Task.sleep(nanoseconds: 2_000_000_000) // 2 second delay
        return []
    }
    func searchSeries(query: String) async throws -> [Series] { [] }
    func fetchSeriesDetail(id: Int) async throws -> SeriesDetail { throw APIError.notFound }
    func fetchEpisodes(forSeriesID id: Int) async throws -> [Episode] { [] }
    func fetchPeople(page: Int) async throws -> [Person] { [] }
    func fetchPersonCredits(personID: Int) async throws -> [CastCredit] { [] }
}
