//
//  SearchViewModelTests.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import XCTest
@testable import MazeWatch

/// Unit tests for SearchViewModel search behavior and error handling.
final class SearchViewModelTests: XCTestCase {

    func testSearchReturnsResults() async {
        let mockClient = MockAPIClient()
        let viewModel = SearchViewModel(apiClient: mockClient)

        viewModel.query = "test"
        try? await Task.sleep(nanoseconds: 500_000_000) // Wait for debounce

        XCTAssertFalse(viewModel.results.isEmpty, "Expected non-empty results for 'test' query")
    }

    func testEmptyQueryClearsResults() async {
        let mockClient = MockAPIClient()
        let viewModel = SearchViewModel(apiClient: mockClient)

        viewModel.query = "test"
        try? await Task.sleep(nanoseconds: 500_000_000)
        viewModel.query = ""
        try? await Task.sleep(nanoseconds: 500_000_000)

        XCTAssertTrue(viewModel.results.isEmpty, "Expected results to clear when query is emptied")
    }

    func testSearchErrorHandled() async {
        let mockClient = MockAPIClient()
        mockClient.shouldThrowError = true
        let viewModel = SearchViewModel(apiClient: mockClient)

        viewModel.query = "error"
        try? await Task.sleep(nanoseconds: 500_000_000)

        XCTAssertTrue(viewModel.results.isEmpty, "Expected results to be empty when API throws error")
    }
}
