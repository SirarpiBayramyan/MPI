//
//  WeatherHomeView.swift
//  WeatherTracker
//
//  Created by Sirarpi Bayramyan on 26.01.25.
//
import SwiftUI

struct WeatherHomeView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        VStack {
            // MARK: - Search Bar
            SearchBarView(query: $viewModel.query) {
                viewModel.isSearching = true
                viewModel.fetchSearchResults()
            }

            // MARK: - Dynamic Content
            if viewModel.isSearching {
                ProgressView()
                    .padding()
            } else if !viewModel.searchResults.isEmpty {
                // Show Search Results
                searchResultsView
            } else if let weather = viewModel.selectedCityWeather {
                // Show Weather Details
                WeatherDetailsView(weather: weather)
            } else if viewModel.query.isEmpty {
                // Show Empty State if no search query
                emptyStateView
            } else if viewModel.shouldShowNoresult {
                // Show No Results Found screen
                noResultsFoundView
            }

            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
        .onAppear {
            viewModel.loadSavedCityWeather()
        }
    }



}

extension WeatherHomeView {

    // MARK: - Empty State View
    private var emptyStateView: some View {
        VStack {
            Spacer()
            Text("No City Selected")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black)
                .padding(.bottom, 8)

            Text("Please Search For A City")
                .font(.system(size: 16))
                .foregroundColor(.gray)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Search Results View
    private var searchResultsView: some View {
        VStack(spacing: 16) {
            ScrollView {
                ForEach(viewModel.searchResults, id: \.id) { result in
                    Button(action: {
                        viewModel.fetchWeather(for: result.location.name)
                    }) {
                        SearchResultCard(weather: result, onTap: {
                            withAnimation(.easeIn) {
                                viewModel.selectedCityWeather = result
                                viewModel.searchResults = []
                            }
                        })
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding(.horizontal)
    }

    private var noResultsFoundView: some View {
        VStack {
            Spacer()
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.gray)
                .padding(.bottom, 16)
            Text("No Results Found")
                .font(.headline)
                .foregroundColor(.black)
            Text("Try searching for a different location.")
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }

}


#Preview {
    WeatherHomeView()
}
