//
//  APIClient.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation

final class APIClient: APIClientProtocol {
    private let baseURL: String

    init(baseURL: String) {
        self.baseURL = baseURL
    }

    func fetchSeries(page: Int) async throws -> [Series] {
        let url = try makeURL(path: Endpoints.Path.shows, queryItems: [URLQueryItem(name: "page", value: "\(page)")])
        return try await fetch(from: url)
    }

    func searchSeries(query: String) async throws -> [Series] {
        let url = try makeURL(path: Endpoints.Path.search, queryItems: [URLQueryItem(name: "q", value: query)])
        let rawResults: [SeriesSearchResult] = try await fetch(from: url)
        return rawResults.map { $0.show }
    }

    func fetchSeriesDetail(id: Int) async throws -> SeriesDetail {
        let url = try makeURL(path: Endpoints.Path.detail(for: id))
        return try await fetch(from: url)
    }

    func fetchEpisodes(forSeriesID id: Int) async throws -> [Episode] {
        let url = try makeURL(path: Endpoints.Path.episodes(for: id))
        return try await fetch(from: url)
    }

    // MARK: - Private Helpers

    private func makeURL(path: String, queryItems: [URLQueryItem]? = nil) throws -> URL {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = queryItems
        guard let url = components?.url else {
            throw APIError.invalidURL
        }
        return url
    }

    private func fetch<T: Decodable>(from url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200...299:
            return try JSONDecoder().decode(T.self, from: data)
        case 404:
            throw APIError.notFound
        default:
            throw APIError.serverError(code: httpResponse.statusCode)
        }
    }
    
    func fetchPeople(page: Int) async throws -> [Person] {
        let url = try makeURL(path: "/people", queryItems: [URLQueryItem(name: "page", value: "\(page)")])
        return try await fetch(from: url)
    }

    func fetchPersonCredits(personID: Int) async throws -> [CastCredit] {
        let url = try makeURL(path: "/people/\(personID)/castcredits", queryItems: [URLQueryItem(name: "embed", value: "show")])
        return try await fetch(from: url)
    }
}

   
