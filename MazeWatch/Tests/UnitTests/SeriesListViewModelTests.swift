//
//  SeriesListViewModelTests.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import XCTest
@testable import MazeWatch

final class SeriesListViewModelTests: XCTestCase {

    func testLoadFirstPageLoadsMockData() async {
        // Given
        let mockClient = MockAPIClient()
        let viewModel = SeriesListViewModel(apiClient: mockClient)

        // When
        await viewModel.loadNextPage()

        // Then
        XCTAssertFalse(viewModel.series.isEmpty, "Series list should not be empty after loading mock data")
        XCTAssertEqual(viewModel.series.count, mockClient.mockSeries.count)
        XCTAssertEqual(viewModel.currentPage, 1)
    }

    func testRefreshClearsAndReloadsData() async {
        // Given
        let mockClient = MockAPIClient()
        let viewModel = SeriesListViewModel(apiClient: mockClient)

        // Load two pages to populate list
        await viewModel.loadNextPage()
        await viewModel.loadNextPage()

        // Ensure initial state
        let beforeRefreshCount = viewModel.series.count
        XCTAssertTrue(beforeRefreshCount > 0)

        // When
        await viewModel.refresh()

        // Then
        XCTAssertEqual(viewModel.currentPage, 1)
        XCTAssertEqual(viewModel.series.count, mockClient.mockSeries.count)
    }

    func testErrorHandling() async {
        // Given
        let mockClient = MockAPIClient()
        mockClient.shouldThrowError = true
        let viewModel = SeriesListViewModel(apiClient: mockClient)

        // When
        await viewModel.loadNextPage()

        // Then
        XCTAssertEqual(viewModel.series.count, 0, "Should not load any series on error")
    }
}
