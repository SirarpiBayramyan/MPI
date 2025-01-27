//
//  WeatherModel.swift
//  WeatherTracker
//
//  Created by Sirarpi Bayramyan on 26.01.25.
//

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable, Identifiable {
    let id = UUID() // Add a unique identifier
    let location: Location
    let current: CurrentWeather
}

extension WeatherModel {
    var uniqueIdentifier: String {
        "\(location.name)-\(UUID())"
    }
}
// MARK: - Location
struct Location: Codable {
    let name: String // City name

}

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    let tempC: Double // Temperature in Celsius
    let condition: WeatherCondition // Weather condition (text and icon)
    let humidity: Int // Humidity percentage
    let uv: Double // UV index
    let feelslikeC: Double // Feels-like temperature in Celsius

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
        case humidity
        case uv
        case feelslikeC = "feelslike_c"
    }
}

// MARK: - WeatherCondition
struct WeatherCondition: Codable {
    let text: String // Description of the weather (e.g., "Partly cloudy")
    let icon: String // Icon URL for the weather condition
}


// MARK: - CitySearchResult
struct CitySearchResult: Codable {
    let name: String
    let country: String
}
