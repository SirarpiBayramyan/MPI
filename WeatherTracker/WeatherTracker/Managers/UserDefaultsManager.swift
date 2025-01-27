//
//  UserDefaultsManager.swift
//  WeatherTracker
//
//  Created by Sirarpi Bayramyan on 26.01.25.
//

import Foundation

class UserDefaultsManager {

    static let shared = UserDefaultsManager()

    private let savedCityKey = "savedCity"

    private init() {} // Private initializer to enforce singleton usage

    // Save the selected city name
    func saveCity(_ city: String) {
        UserDefaults.standard.set(city, forKey: savedCityKey)
    }

    // Retrieve the saved city name
    func getSavedCity() -> String? {
        UserDefaults.standard.string(forKey: savedCityKey)
    }

    // Clear the saved city
    func clearSavedCity() {
        UserDefaults.standard.removeObject(forKey: savedCityKey)
    }
}


