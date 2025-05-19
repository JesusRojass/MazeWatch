//
//  ChunkedExtensionTests.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import XCTest
@testable import MazeWatch

final class ChunkedExtensionTests: XCTestCase {

    func testChunkingWithValidSize() {
        let array = Array(1...10)
        let chunks = array.chunked(into: 3)
        XCTAssertEqual(chunks.count, 4)
        XCTAssertEqual(chunks[0], [1, 2, 3])
    }

    func testChunkingWithOversizedChunk() {
        let array = Array(1...5)
        let chunks = array.chunked(into: 10)
        XCTAssertEqual(chunks.count, 1)
        XCTAssertEqual(chunks[0], array)
    }

    func testChunkingWithInvalidSize() {
        let array = Array(1...5)
        let chunks = array.chunked(into: 0)
        XCTAssertEqual(chunks.count, 1)
        XCTAssertEqual(chunks[0], array)
    }

    func testEmptyArrayChunking() {
        let array: [Int] = []
        let chunks = array.chunked(into: 3)
        XCTAssertTrue(chunks.isEmpty)
    }
}
