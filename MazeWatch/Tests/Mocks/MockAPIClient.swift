//
//  MockAPIClient.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation

final class MockAPIClient: APIClientProtocol {

    // MARK: - Toggleable Behavior for Testing
    var mockSeries: [Series] = [
        Series(id: 1, name: "Breaking Test", image: nil),
        Series(id: 2, name: "Swift & Furious", image: nil)
    ]

    var mockDetail: SeriesDetail = SeriesDetail(
        id: 1,
        name: "Breaking Test",
        image: nil,
        schedule: .init(time: "21:00", days: ["Monday"]),
        genres: ["Drama", "Test"],
        summary: "A test summary for a fake series."
    )

    var mockEpisodes: [Episode] = [
        Episode(id: 1, name: "Pilot", season: 1, number: 1, summary: "Test pilot episode", image: nil)
    ]

    var shouldThrowError = false

    // MARK: - APIClientProtocol

    func fetchSeries(page: Int) async throws -> [Series] {
        if shouldThrowError { throw APIError.serverError(code: 500) }
        return mockSeries
    }

    func searchSeries(query: String) async throws -> [Series] {
        if shouldThrowError { throw APIError.notFound }
        return mockSeries.filter { $0.name.lowercased().contains(query.lowercased()) }
    }

    func fetchSeriesDetail(id: Int) async throws -> SeriesDetail {
        if shouldThrowError { throw APIError.notFound }
        return mockDetail
    }

    func fetchEpisodes(forSeriesID id: Int) async throws -> [Episode] {
        if shouldThrowError { throw APIError.invalidResponse }
        return mockEpisodes
    }
}
