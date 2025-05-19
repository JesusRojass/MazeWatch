//
//  SearchViewModel.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation
import Combine

/// ViewModel responsible for handling search logic and debouncing user input.
final class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var results: [Series] = []
    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
        setupBindings()
    }

    /// Sets up Combine pipeline to debounce query and trigger search
    private func setupBindings() {
        $query
            .removeDuplicates()
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .sink { [weak self] text in
                Task { await self?.search(query: text) }
            }
            .store(in: &cancellables)
    }

    /// Executes the search call via API client
    @MainActor
    func search(query: String) async {
        guard !query.isEmpty else {
            results = []
            return
        }

        isLoading = true
        do {
            let response = try await apiClient.searchSeries(query: query)
            results = response
        } catch {
            print("Search error: \(error)")
            results = []
        }
        isLoading = false
    }
}
