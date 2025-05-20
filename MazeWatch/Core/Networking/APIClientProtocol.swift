//
//  APIClientProtocol.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation

protocol APIClientProtocol {
    func fetchSeries(page: Int) async throws -> [Series]
    func searchSeries(query: String) async throws -> [Series]
    func fetchSeriesDetail(id: Int) async throws -> SeriesDetail
    func fetchEpisodes(forSeriesID id: Int) async throws -> [Episode]
    func fetchPeople(page: Int) async throws -> [Person]
    func fetchPersonCredits(personID: Int) async throws -> [CastCredit]
}
