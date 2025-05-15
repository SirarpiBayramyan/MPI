//
//  ContentView.swift
//  NewsReader
//
//  Created by Sirarpi Bayramyan on 15.05.25.
//
import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = NewsViewModel()
    @State private var selectedArticle: Article?

    var body: some View {
        NavigationStack {
            List(viewModel.articles) { article in
                NavigationLink(
                    destination: {
                        if let url = URL(string: article.url) {
                            WebView(url: url)
                                .navigationTitle("Article")
                                .navigationBarTitleDisplayMode(.inline)
                        } else {
                            Text("Invalid URL")
                        }
                    },
                    label: {
                        HStack(alignment: .top, spacing: 12) {
                            AsyncImage(url: URL(string: article.urlToImage)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                            }
                            .frame(width: 100, height: 70)
                            .cornerRadius(8)

                            VStack(alignment: .leading, spacing: 6) {
                                Text(article.title)
                                    .font(.headline)
                                    .lineLimit(2)

                                if !article.description.isEmpty {
                                    Text(article.description)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .lineLimit(2)
                                }
                            }
                        }
                    }
                )
            }
            .navigationTitle("Top Headlines")
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .task {
                await viewModel.loadNews()
            }
        }
    }
}
