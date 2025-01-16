//
//  Event.swift
//  CountDown
//
//  Created by Sirarpi Bayramyan on 16.01.25.
//

import Foundation

struct Event: Hashable, Codable {
    var id = UUID()
    var name: String
    var emojy: String
    var date: Date
    var notes: String
}

protocol EventStorageService {
    func saveEvents(_ events: [Event])
    func fetchEvents() -> [Event]
}

import Foundation

class UserDefaultsEventStorageService: EventStorageService {
    private let userDefaultsKey = "savedEvents"

    func saveEvents(_ events: [Event]) {
        if let encodedData = try? JSONEncoder().encode(events) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
        }
    }

    func fetchEvents() -> [Event] {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedEvents = try? JSONDecoder().decode([Event].self, from: data) {
            return decodedEvents
        }
        return []
    }
}

