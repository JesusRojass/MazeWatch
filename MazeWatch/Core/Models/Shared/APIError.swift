//
//  APIError.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case notFound
    case serverError(code: Int)
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid response"
        case .notFound: return "Resource not found"
        case .serverError(let code): return "Server error \(code)"
        case .decodingFailed: return "Failed to decode response"
        }
    }
}
