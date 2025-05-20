//
//  LockScreenView.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 19/05/25.
//

import SwiftUI
import LocalAuthentication

struct LockScreenView: View {
    @AppStorage("userPIN") private var storedPIN: String = ""
    @AppStorage("biometricsEnabled") private var biometricsEnabled: Bool = false
    let onUnlock: () -> Void

    @State private var input = ""
    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter PIN to Continue")
                .font(.headline)

            SecureField("PIN", text: $input)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .frame(width: 150)

            Button("Unlock") {
                if input == storedPIN {
                    onUnlock()
                } else {
                    errorMessage = "Incorrect PIN"
                }
            }
            .disabled(input.isEmpty)

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .onAppear {
            if biometricsEnabled {
                authenticateWithBiometrics()
            }
        }
    }

    func authenticateWithBiometrics() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Unlock MazeWatch") { success, _ in
                if success {
                    DispatchQueue.main.async {
                        onUnlock()
                    }
                }
            }
        }
    }
}
