//
//  SeriesDetail.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation

struct SeriesDetail: Codable, Identifiable {
    let id: Int
    let name: String
    let image: Series.ImageLinks?
    let schedule: Schedule
    let genres: [String]
    let summary: String?

    struct Schedule: Codable {
        let time: String
        let days: [String]
    }
}
