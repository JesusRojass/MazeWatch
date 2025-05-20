//
//  PersonDetailViewModel.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 19/05/25.
//

import Foundation

/// ViewModel responsible for loading a person's cast credits (series they’ve appeared in).
final class PersonDetailViewModel: ObservableObject {
    @Published var credits: [CastCredit] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?

    private let personID: Int
    private let apiClient: APIClientProtocol

    init(personID: Int, apiClient: APIClientProtocol = APIClient(baseURL: "https://api.tvmaze.com")) {
        self.personID = personID
        self.apiClient = apiClient
    }

    @MainActor
    func loadCredits() {
        guard !isLoading else { return }

        isLoading = true
        Task {
            do {
                let fetchedCredits = try await apiClient.fetchPersonCredits(personID: personID)
                credits = fetchedCredits
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }
}
