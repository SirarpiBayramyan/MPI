//
//  WeatherViewModel.swift
//  WeatherTracker
//
//  Created by Sirarpi Bayramyan on 26.01.25.
//
import Combine
import Foundation

class WeatherViewModel: ObservableObject {
    
    @Published var selectedCityWeather: WeatherModel?
    @Published var searchResults: [WeatherModel] = [] // Changed from [String] to [WeatherModel]
    @Published var isSearching: Bool = false
    @Published var shouldShowNoresult = false
    @Published var errorMessage: String? = nil
    @Published var query: String = "" // City search query
    
    private var weatherAPIService: WeatherAPIService
    
    init(weatherAPIService: WeatherAPIService = WeatherAPIService()) {
        self.weatherAPIService = weatherAPIService
    }
    
    // Fetch weather for a specific city
    func fetchWeather(for cityName: String) {
        Task {
            do {
                // Fetch weather data asynchronously
                let weather = try await weatherAPIService.fetchWeather(for: cityName)
                // Update the UI on the main thread
                DispatchQueue.main.async {
                    self.selectedCityWeather = weather
                    self.errorMessage = nil
                    self.isSearching = false
                    // Save the selected city to UserDefaults
                    UserDefaultsManager.shared.saveCity(cityName)
                }
            } catch {
                // Handle error
                DispatchQueue.main.async {
                    self.handleError(error)
                }
            }
        }
    }
    
    func fetchSearchResults() {
        isSearching = true
        Task {
            do {
                // Fetch city names from the API
                let cityNames = try await weatherAPIService.searchCities(query: query)
                if cityNames.isEmpty {
                    UserDefaultsManager.shared.clearSavedCity()
                    DispatchQueue.main.async {
                        self.shouldShowNoresult = true
                        self.selectedCityWeather = nil
                        self.isSearching = false
                    }
                }

                // Convert city names to WeatherModel objects by fetching weather data in parallel
                let results = try await fetchWeatherForCities(cityNames)


                // Update search results on the main thread
                DispatchQueue.main.async {
                    self.searchResults = results
                    self.isSearching = false
                }
            } catch let error as WeatherAPIServiceError {
                DispatchQueue.main.async {
                    self.errorMessage = error.errorDescription
                    self.isSearching = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "An unknown error occurred."
                    self.isSearching = false
                }
            }
        }
    }
    
    
    func loadSavedCityWeather() {
        if let savedCity = UserDefaultsManager.shared.getSavedCity() {
            fetchWeather(for: savedCity)
        }
    }
    
    // Helper function to fetch weather data for multiple cities in parallel
    private func fetchWeatherForCities(_ cityNames: [String]) async throws -> [WeatherModel] {
        await withTaskGroup(of: WeatherModel?.self) { group in
            var results: [WeatherModel] = []
            
            for cityName in cityNames {
                group.addTask {
                    do {
                        return try await self.weatherAPIService.fetchWeather(for: cityName)
                    } catch {
                        print("Failed to fetch weather for city '\(cityName)': \(error.localizedDescription)")
                        return nil
                    }
                }
            }
            
            for await result in group {
                if let weather = result {
                    results.append(weather)
                }
            }
            
            return results
        }
    }
    
    // Handle errors appropriately
    private func handleError(_ error: Error) {
        if let apiError = error as? WeatherAPIServiceError {
            switch apiError {
            case .networkError:
                self.errorMessage = "Network error. Please check your internet connection."
            case .decodingError:
                self.errorMessage = "There was an error decoding the weather data."
            case .invalidData:
                self.errorMessage = "No data received from the weather API."
            case .apiError(let message):
                self.errorMessage = message
            case .invalidURL:
                self.errorMessage = "Invalid URL."
            case .unknownError(let error):
                self.errorMessage = "An unknown error occurred: \(error.localizedDescription)"
            }
        } else {
            self.errorMessage = "An unknown error occurred: \(error.localizedDescription)"
        }
    }
    
}
