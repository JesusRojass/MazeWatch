//
//  AppLaunchUITests.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import XCTest

final class AppLaunchUITests: XCTestCase {

    func testScrollTriggersPagination() {
        let app = XCUIApplication()
        app.launch()

        let firstCell = app.scrollViews.children(matching: .other).element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "First series card should exist")

        // Try to scroll several times
        for _ in 0..<10 {
            app.swipeUp()
            sleep(1)
        }

        // Check for more cards (assumes mock or API loads new content)
        let cellCount = app.scrollViews.children(matching: .other).count
        XCTAssertGreaterThan(cellCount, 20, "Pagination should load more than 20 series cards")
    }
}
