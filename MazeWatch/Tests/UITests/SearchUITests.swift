//
//  SearchUITests.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import XCTest

/// UI tests to verify search functionality and result interaction.
final class SearchUITests: XCTestCase {

    func testTypingInSearchBarShowsResults() {
        let app = XCUIApplication()
        app.launch()

        let searchTab = app.tabBars.buttons["Search"]
        XCTAssertTrue(searchTab.waitForExistence(timeout: 2))
        searchTab.tap()

        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists)
        searchField.tap()
        searchField.typeText("test")

        sleep(2) // Allow time for debounce and result population

        let results = app.cells.count
        XCTAssertGreaterThan(results, 0, "Expected at least one result to appear")
    }
}
