//
//  WeatherRepositoryProtocol.swift
//  WeatherTracker
//
//  Created by Sirarpi Bayramyan on 26.01.25.
//
import Combine

protocol WeatherRepositoryProtocol {
    
    func fetchWeather(for city: String) -> AnyPublisher<WeatherModel, WeatherAPIServiceError>

}

