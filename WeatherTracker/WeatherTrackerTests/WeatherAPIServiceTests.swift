//
//  WeatherAPIServiceTests.swift
//  WeatherTrackerTests
//
//  Created by Sirarpi Bayramyan on 26.01.25.
//

import XCTest
@testable import WeatherTracker

final class WeatherAPIServiceTests: XCTestCase {

    var weatherAPIService: WeatherAPIService!

    override func setUp() {
        super.setUp()
        weatherAPIService = WeatherAPIService()
    }

    override func tearDown() {
        weatherAPIService = nil
        super.tearDown()
    }

    func testFetchWeather_Success() async throws {
        // Arrange
        let city = "London"

        // Act
        let weather = try await weatherAPIService.fetchWeather(for: city)

        // Assert
        XCTAssertEqual(weather.location.name, "London")
        XCTAssertNotNil(weather.current.tempC)
    }

    func testSearchCities_Success() async throws {
        // Arrange
        let query = "Lon"

        // Act
        let cities = try await weatherAPIService.searchCities(query: query)

        // Assert
        XCTAssertGreaterThan(cities.count, 0)
        XCTAssertTrue(cities.contains("London"))
    }

    func testSearchCities_NoResults() async throws {
        // Arrange
        let query = "InvalidCityQuery123"

        // Act
        let cities = try await weatherAPIService.searchCities(query: query)

        // Assert
        XCTAssertEqual(cities.count, 0)
    }
}
