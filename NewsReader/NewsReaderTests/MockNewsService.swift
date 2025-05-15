//
//  MockNewsService.swift
//  NewsReaderTests
//
//  Created by Sirarpi Bayramyan on 15.05.25.
//

import Foundation
@testable import NewsReader

class MockNewsService: NewsServiceProtocol {
    var shouldFail = false

    func fetchNewsData() async throws -> [Article] {
        if shouldFail {
            throw URLError(.badServerResponse)
        }

        return [
            Article(
                title: "Test Title",
                description: "Test Description",
                url: "https://example.com",
                urlToImage: "https://example.com/image.jpg"
            )
        ]
    }
}
