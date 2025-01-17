//
//  CreateNewEventViewModel.swift
//  CountDown
//
//  Created by Sirarpi Bayramyan on 16.01.25.
//

import Foundation
import SwiftUI

class CreateNewEventViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var emoji: String = "🎁"
    @Published var date: Date = Date()
    @Published var notes: String = "descr"


    private var cache = UserDefaultsEventStorageService.shared
    private var calendarServie = CalendarEventService()
    
    init() {
        self.name = ""
        self.emoji = ""
        self.date = Date()
        self.notes = "mmm"
    }
    
    init(event: Event) {
        self.name = event.name
        self.emoji = event.emoji
        self.date = event.date
        self.notes = event.notes
    }
    
    var isSaveDisabled: Bool {
        name.isEmpty || emoji.isEmpty || notes.isEmpty
    }
    
    func saveEvent(alertMessage: Binding<String>, showAlert: Binding<Bool>) {
        let event = Event(name: name, emoji: emoji, date: date, notes: notes)
        calendarServie.checkCalendarAccess(add: event, alertMessage: alertMessage, showAlert: showAlert)
        var events = cache.fetchEvents()
        events.append(event)
        cache.saveEvents(events)

    }
    
    
    // Method to calculate time remaining for a specific event
    
    
    func deleteEvent() {
        var events = cache.fetchEvents()
        let event = Event(name: name, emoji: emoji, date: date, notes: notes)
        for i in 0..<events.count {
            if events[i] == event {
                events.remove(at: i)
                cache.saveEvents(events)
            }
        }
    }

}
