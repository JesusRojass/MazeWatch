//
//  SettingsView.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 19/05/25.
//

import SwiftUI
import LocalAuthentication

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showingPinEditor = false
    @State private var showingClearPinAlert = false
    @State private var newPin = ""
    @FocusState private var isPinFieldFocused: Bool

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Security")) {
                    if viewModel.pin.isEmpty {
                        Button("Set PIN") {
                            showingPinEditor = true
                        }
                    } else {
                        HStack {
                            SecureField("PIN", text: .constant("••••"))
                            Spacer()
                            Button("Edit") {
                                showingPinEditor = true
                            }
                        }

                        Button("Clear PIN", role: .destructive) {
                            showingClearPinAlert = true
                        }
                    }

                    Toggle("Enable Face ID / Touch ID", isOn: $viewModel.biometricsEnabled)
                        .onChange(of: viewModel.biometricsEnabled) { _, newValue in
                            viewModel.toggleBiometrics(enabled: newValue)
                        }
                }

                Section(header: Text("Actions")) {
                    Button("Clear Favorites", role: .destructive) {
                        viewModel.clearFavorites()
                    }
                }
            }
            .navigationTitle("Settings")
            .alert("Clear PIN?", isPresented: $showingClearPinAlert) {
                Button("Delete", role: .destructive) {
                    viewModel.clearPin()
                }
                Button("Cancel", role: .cancel) { }
            }
            .sheet(isPresented: $showingPinEditor) {
                NavigationView {
                    Form {
                        SecureField("Enter new PIN", text: $newPin)
                            .keyboardType(.numberPad)
                            .focused($isPinFieldFocused)
                        Button("Save") {
                            viewModel.setPin(newPin)
                            newPin = ""
                            showingPinEditor = false
                        }
                        .disabled(newPin.isEmpty)
                    }
                    .navigationTitle("Set PIN")
                    .toolbar {
                        ToolbarItem(placement: .keyboard) {
                            Button("Done") {
                                isPinFieldFocused = false
                            }
                        }
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showingPinEditor = false
                                newPin = ""
                                isPinFieldFocused = false
                            }
                        }
                    }
                }
            }
        }
    }
}
