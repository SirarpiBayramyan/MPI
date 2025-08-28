//  NewsReaderTests
//
//  Created by Sirarpi Bayramyan on 15.05.25.
//

// NewsViewModelTests.swift
import XCTest
@testable import NewsReader

final class NewsViewModelTests: XCTestCase {

    func testLoadNews_Success() async throws {
        let mockService = MockNewsService()
        let viewModel = NewsViewModel(service: mockService)

        await viewModel.loadNews()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.articles.count, 1)
        XCTAssertEqual(viewModel.articles.first?.title, "Test Title")
    }

    func testLoadNews_Failure() async throws {
        let mockService = MockNewsService()
        mockService.shouldFail = true
        let viewModel = NewsViewModel(service: mockService)

        await viewModel.loadNews()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.articles.isEmpty)
    }
}
