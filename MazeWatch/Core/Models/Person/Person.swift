//
//  Person.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation

struct Person: Codable, Identifiable {
    let id: Int
    let name: String
    let image: Series.ImageLinks?
}
