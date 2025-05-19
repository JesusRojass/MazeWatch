//
//  View+Extensions.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import SwiftUI

/// Extension to dismiss keyboard from any SwiftUI View.
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
