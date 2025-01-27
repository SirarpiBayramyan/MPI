//
//  WeatherTrackerTests.swift
//  WeatherTrackerTests
//
//  Created by Sirarpi Bayramyan on 26.01.25.
//

import XCTest
@testable import WeatherTracker

final class WeatherViewModelTests: XCTestCase {

    var viewModel: WeatherViewModel!
    var mockService: MockWeatherAPIService!

    override func setUp() {
        super.setUp()
        mockService = MockWeatherAPIService()
        viewModel = WeatherViewModel(weatherAPIService: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testFetchWeather_Success() async {
        // Arrange
        let city = "London"

        // Act
        viewModel.fetchWeather(for: city)
        await waitFor {
            self.viewModel.selectedCityWeather != nil
        }

        // Assert
        XCTAssertEqual(viewModel.selectedCityWeather?.location.name, "London")
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchWeather_Error() async {
        // Arrange
        mockService.shouldReturnError = true

        // Act
        viewModel.fetchWeather(for: "InvalidCity")
        await waitFor {
            self.viewModel.errorMessage != nil
        }

        // Assert
        XCTAssertNotNil(viewModel.errorMessage)
    }

    func testFetchSearchResults_Success() async {
        // Arrange
        viewModel.query = "Lo"

        // Act
        viewModel.fetchSearchResults()
        await waitFor {
            !self.viewModel.searchResults.isEmpty
        }

        // Assert
        XCTAssertEqual(viewModel.searchResults.count, 3)
        XCTAssertEqual(viewModel.searchResults.first?.location.name, "London")
    }

    func testFetchSearchResults_Error() async {
        // Arrange
        mockService.shouldReturnError = true
        viewModel.query = "Lo"

        // Act
        viewModel.fetchSearchResults()
        await waitFor {
            self.viewModel.errorMessage != nil
        }

        // Assert
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.searchResults.isEmpty)
    }
}

// Helper to wait for async conditions
extension XCTestCase {
    func waitFor(condition: @escaping () -> Bool, timeout: TimeInterval = 2) async {
        let expectation = XCTestExpectation(description: "Wait for condition to be true")
        Task {
            while !condition() {
                await Task.sleep(10_000_000) // 10ms
            }
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: timeout)
    }
}
