//
//  Episode.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation

struct Episode: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let summary: String?
    let image: Series.ImageLinks?
}
