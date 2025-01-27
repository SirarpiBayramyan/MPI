//
//  WeatherAPIServiceError.swift
//  WeatherTracker
//
//  Created by Sirarpi Bayramyan on 26.01.25.
//

import Foundation

enum WeatherAPIServiceError: Error, LocalizedError {
    case networkError(Error)
    case decodingError
    case invalidData
    case apiError(String)
    case unknownError(Error)
    case invalidURL
    
    var errorDescription: String? {
        switch self {
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .decodingError:
            return "Failed to decode weather data."
        case .invalidData:
            return "Invalid data received from the server."
        case .apiError(let message):
            return "API error: \(message)"
        case .unknownError(let error):
            return "Unknown error: \(error.localizedDescription)"
        case .invalidURL:
            return "The URL is invalid."
        }
    }
}
