//
//  SwttingsViewModel.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 19/05/25.
//

import Foundation
import LocalAuthentication
import CoreData
import SwiftUI

final class SettingsViewModel: ObservableObject {
    @AppStorage("userPIN") var pin: String = ""
    @AppStorage("biometricsEnabled") var biometricsEnabled: Bool = false

    /// Triggers biometric authentication when toggled on
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Enable secure access") { success, authError in
                DispatchQueue.main.async {
                    if !success {
                        self.biometricsEnabled = false
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.biometricsEnabled = false
            }
        }
    }

    /// Deletes all favorite records from Core Data
    func clearFavorites() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = FavoriteSeries.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to clear favorites: \(error.localizedDescription)")
        }
    }

    /// Sets a new PIN
    func setPin(_ newPin: String) {
        pin = newPin
    }

    /// Clears the currently stored PIN
    func clearPin() {
        pin = ""
    }

    /// Toggles biometric setting and authenticates if enabling
    func toggleBiometrics(enabled: Bool) {
        biometricsEnabled = enabled
        if enabled {
            authenticate()
        }
    }
}
