//
//  NewsViewModel.swift
//  NewsReader
//
//  Created by Sirarpi Bayramyan on 15.05.25.
//

import Foundation

class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service: NewsServiceProtocol

    init(service: NewsServiceProtocol = NewsReadingManager()) {
        self.service = service
    }

    func loadNews() async {
        isLoading = true
        errorMessage = nil
        do {
            articles = try await service.fetchNewsData()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

}
