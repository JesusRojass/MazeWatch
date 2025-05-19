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

    struct ImageLinks: Codable, Hashable {
        let medium: String?
        let original: String?
    }
}
