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
    var emoji: String
    var date: Date
    var notes: String
}

//protocol EventStorageService {
//    func saveEvents(_ events: [Event])
//    func fetchEvents() -> [Event]
//
//}

class UserDefaultsEventStorageService {
    static let shared = UserDefaultsEventStorageService()
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

    func delete(event: Event) {
        var events = fetchEvents()
        events.removeAll { $0.id == event.id } // Remove the event by matching its ID
        saveEvents(events) // Save the updated list
    }
}
