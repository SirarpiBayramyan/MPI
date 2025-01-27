//
//  MockWeatherAPIService.swift
//  WeatherTrackerTests
//
//  Created by Sirarpi Bayramyan on 27.01.25.
//

import Foundation
@testable import WeatherTracker


class MockWeatherAPIService: WeatherAPIService {
    var shouldReturnError = false

    override func fetchWeather(for city: String) async throws -> WeatherModel {
        if shouldReturnError {
            throw WeatherAPIServiceError.apiError("Mock error fetching weather.")
        }

        return WeatherModel(
            location: Location(name: city),
            current: CurrentWeather(
                tempC: 25,
                condition: WeatherCondition(text: "Sunny", icon: "/weather/64x64/day/113.png"),
                humidity: 60,
                uv: 5.0,
                feelslikeC: 27.0
            )
        )
    }

    override func searchCities(query: String) async throws -> [String] {
        if shouldReturnError {
            throw WeatherAPIServiceError.apiError("Mock error searching cities.")
        }

        return ["London", "Los Angeles", "Lisbon"]
    }
}
