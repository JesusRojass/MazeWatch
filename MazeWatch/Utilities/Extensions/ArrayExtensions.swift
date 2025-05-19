//
//  Array+Extensions.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation

/// Utility extension to break an array into evenly sized chunks.
extension Array {

    /// Breaks the array into chunks of the specified size.
    /// - Parameter size: The desired maximum number of elements per chunk.
    /// - Returns: An array of array chunks. Returns the full array in one chunk if size is invalid.
    func chunked(into size: Int) -> [[Element]] {
        guard size > 0 && size < count else {
            return [self] // Return entire array if chunking isn't meaningful or possible
        }
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
