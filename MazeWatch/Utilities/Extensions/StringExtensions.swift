//
//  StringExtensions.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 19/05/25.
//

import Foundation

// MARK: - HTML stripping utility
extension String {
    /// Removes HTML tags and entities for cleaner text rendering.
    var strippedHTML: String {
        guard let data = data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        return (try? NSAttributedString(data: data, options: options, documentAttributes: nil).string) ?? self
    }
}
