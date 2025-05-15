//
//  NewsReadingManager.swift
//  NewsReader
//
//  Created by Sirarpi Bayramyan on 15.05.25.
//

import Foundation

protocol NewsServiceProtocol {
    func fetchNewsData() async throws -> [Article]
}


enum NewsServiceError: Error {
    case invalidURL
    case badResponse
}

class NewsReadingManager: NewsServiceProtocol {

    private let key = "e701e38ca69e45a78cc0b48a2191a223"

    func fetchNewsData() async throws -> [Article] {

        let urlString = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=\(key)"

        guard let url = URL(string: urlString) else {
            throw NewsServiceError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NewsServiceError.badResponse
        }

        let decoded = try JSONDecoder().decode(NewsResponse.self, from: data)

        return decoded.articles
    }


}
