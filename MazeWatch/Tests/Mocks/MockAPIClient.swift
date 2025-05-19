//
//  MockAPIClient.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

@testable import MazeWatch
import Foundation

/// Mock implementation of APIClientProtocol for unit testing and previews.
final class MockAPIClient: APIClientProtocol {

    // MARK: - Toggleable Behavior for Testing

    /// Sample series list used for list and search previews.
    var mockSeries: [Series] = [
        Series(
            id: 1,
            name: "Breaking Test",
            image: .init(medium: nil, original: nil),
            genres: ["Drama", "Action"],
            premiered: "2020-05-10",
            network: .init(name: "MockFlix")
        ),
        Series(
            id: 2,
            name: "Swift & Furious",
            image: .init(medium: nil, original: nil),
            genres: ["Thriller"],
            premiered: "2022-08-15",
            network: .init(name: "CodeMax")
        )
    ]

    /// Sample series detail for previewing detail screen.
    var mockDetail: SeriesDetail = SeriesDetail(
        id: 1,
        name: "Breaking Test",
        image: nil,
        schedule: .init(time: "21:00", days: ["Monday"]),
        genres: ["Drama", "Test"],
        summary: "<p>A test summary for a <b>fake</b> series with HTML.</p>"
    )

    /// Sample episodes grouped under one season.
    var mockEpisodes: [Episode] = [
        Episode(id: 1, name: "Pilot", season: 1, number: 1, summary: "Test pilot episode", image: nil),
        Episode(id: 2, name: "Follow-up", season: 1, number: 2, summary: nil, image: nil),
        Episode(id: 3, name: "Comeback", season: 2, number: 1, summary: "Season two starts", image: nil)
    ]

    /// Toggles error behavior for testing edge cases.
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
