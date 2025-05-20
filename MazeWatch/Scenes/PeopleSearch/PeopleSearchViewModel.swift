//
//  PeopleSearchViewModel.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation

final class PeopleSearchViewModel: ObservableObject {
    @Published var people: [Person] = []
    @Published var isLoading = false
    private var currentPage = 0
    private var canLoadMore = true

    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClient(baseURL: "https://api.tvmaze.com")) {
        self.apiClient = apiClient
    }

    @MainActor
    func loadNextPage() {
        guard !isLoading, canLoadMore else { return }

        isLoading = true
        Task {
            do {
                let newPeople = try await apiClient.fetchPeople(page: currentPage)
                if newPeople.isEmpty {
                    canLoadMore = false
                } else {
                    people += newPeople
                    currentPage += 1
                }
            } catch {
                print("Failed to fetch people: \(error)")
            }
            isLoading = false
        }
    }
}
