//
//  Endpoints.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation

/// Centralized API endpoint definitions.
enum Endpoints {
    /// The base URL for all API requests.
    static let baseURL = "https://api.tvmaze.com"

    enum Path {
        static let shows = "/shows"
        static let search = "/search/shows?q="

        static func detail(for id: Int) -> String {
            "/shows/\(id)"
        }

        static func episodes(for id: Int) -> String {
            "/shows/\(id)/episodes"
        }
    }
}
