//
//  WeatherAPIService.swift
//  WeatherTracker
//
//  Created by Sirarpi Bayramyan on 26.01.25.
//

import Foundation

class WeatherAPIService {
    
    private let apiKey = "be1b5f123950405bb85111523252601"

    private let baseURL = "https://api.weatherapi.com/v1"
    
    // Asynchronous method to fetch weather data
    func fetchWeather(for city: String) async throws -> WeatherModel {
        guard let url = URL(string: "\(baseURL)/current.json?key=be1b5f123950405bb85111523252601&q=\(city)") else {
            throw WeatherAPIServiceError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            try validateHTTPResponse(response)
            
            // Ensure data is valid
            guard !data.isEmpty else {
                throw WeatherAPIServiceError.invalidData
            }
            
            return try decodeWeatherData(data)
            
        } catch let error as URLError {
            throw WeatherAPIServiceError.networkError(error)
        } catch let error as DecodingError {
            throw WeatherAPIServiceError.decodingError
        } catch {
            throw WeatherAPIServiceError.unknownError(error)
        }
    }
    
    // Method to search cities by a query string
    func searchCities(query: String) async throws -> [String] {
        guard let url = URL(string: "\(baseURL)/search.json?key=be1b5f123950405bb85111523252601&q=\(query)") else {
            throw WeatherAPIServiceError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            try validateHTTPResponse(response)
            guard !data.isEmpty else {
                throw WeatherAPIServiceError.invalidData
            }
            return try decodeCitySearchResults(data)
        } catch let error as URLError {
            throw WeatherAPIServiceError.networkError(error)
        } catch let error as DecodingError {
            throw WeatherAPIServiceError.decodingError
        } catch {
            throw WeatherAPIServiceError.unknownError(error)
        }
    }
    
    
    // Validate the HTTP response
    private func validateHTTPResponse(_ response: URLResponse?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw WeatherAPIServiceError.apiError("Received invalid response.")
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw WeatherAPIServiceError.apiError("Received error HTTP status code: \(httpResponse.statusCode)")
        }
    }
    
    // Decode the weather data
    private func decodeWeatherData(_ data: Data) throws -> WeatherModel {
        do {
            let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
            return weatherModel
        } catch {
            throw WeatherAPIServiceError.decodingError
        }
    }
    
    // Decode city search results
    private func decodeCitySearchResults(_ data: Data) throws -> [String] {
        let decoder = JSONDecoder()
        let cityResults = try decoder.decode([CitySearchResult].self, from: data)
        return cityResults.map { $0.name }
    }

}

