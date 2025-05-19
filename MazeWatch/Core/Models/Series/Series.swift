//
//  Series.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation

struct Series: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let image: ImageLinks?
    let genres: [String]?
    let premiered: String?
    let network: Network?

    struct ImageLinks: Codable, Hashable {
        let medium: String?
        let original: String?
    }

    struct Network: Codable, Hashable {
        let name: String
    }
}
