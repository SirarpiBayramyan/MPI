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
    @Published var emojy: String = "🎁"
    @Published var date: Date = Date()
    @Published var notes: String = "descr"
    
    
    private var calendarServie = CalendarEventService()
    
    init() {
        self.name = ""
        self.emojy = ""
        self.date = Date()
        self.notes = "mmm"
    }
    
    init(event: Event) {
        self.name = event.name
        self.emojy = event.emojy
        self.date = event.date
        self.notes = event.notes
    }
    
    var isSaveDisabled: Bool {
        name.isEmpty || emojy.isEmpty || notes.isEmpty
    }
    
    func saveEvent(alertMessage: Binding<String>, showAlert: Binding<Bool>) {
        let event = Event(name: name, emojy: emojy, date: date, notes: notes)
        
        calendarServie.checkCalendarAccess(add: event, alertMessage: alertMessage, showAlert: showAlert)
    }
    
    
    // Method to calculate time remaining for a specific event
    func timeRemaining() -> String {
        let now = Date()
        let components = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: now, to: date)
        
        guard let days = components.day, let hours = components.hour, let minutes = components.minute, let seconds = components.second else {
            return "Time calculation error"
        }
        
        if now > date {
            return "Event has passed"
        }
        
        return "\(days)d \(hours)h \(minutes)m \(seconds)s"
    }
    
    
}
