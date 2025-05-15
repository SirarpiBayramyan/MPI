//
//  NewsResponse.swift
//  NewsReader
//
//  Created by Sirarpi Bayramyan on 15.05.25.
//

import Foundation

// MARK: - NewsResponse
struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Identifiable {
    var id: String { url }
    let title, description: String
    let url: String
    let urlToImage: String
}
