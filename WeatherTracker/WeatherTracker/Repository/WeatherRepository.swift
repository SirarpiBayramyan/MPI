//
//  WeatherRepository.swift
//  WeatherTracker
//
//  Created by Sirarpi Bayramyan on 26.01.25.
//
import Combine

class WeatherRepository: WeatherRepositoryProtocol {

    private let weatherService: WeatherAPIService

    init(weatherService: WeatherAPIService = WeatherAPIService()) {
        self.weatherService = weatherService
    }

    // Fetch weather for a specific city (using async/await)
    func fetchWeather(for city: String) -> AnyPublisher<WeatherModel, WeatherAPIServiceError> {
        return Future<WeatherModel, WeatherAPIServiceError> { promise in
            Task {
                do {
                    // Call the service to fetch the weather
                    let weatherModel = try await self.weatherService.fetchWeather(for: city)
                    promise(.success(weatherModel))
                } catch let error as WeatherAPIServiceError {
                    // Handle and return the specific error
                    promise(.failure(error))
                } catch {
                    // Handle any other unknown errors
                    promise(.failure(.unknownError(error)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
