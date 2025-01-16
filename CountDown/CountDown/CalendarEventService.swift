//
//  CalendarEventService.swift
//  CountDown
//
//  Created by Sirarpi Bayramyan on 16.01.25.
//
import SwiftUI
import EventKit

struct CalendarEventService {
    let eventStore = EKEventStore()

    private func createEvent(eventt: Event) {
            // Create a new event
            let event = EKEvent(eventStore: eventStore)
        event.title = eventt.name
        event.startDate = eventt.date  // 2 hours from now
        event.notes = eventt.notes
            event.calendar = eventStore.defaultCalendarForNewEvents // Use default calendar

            do {
                try eventStore.save(event, span: .thisEvent)
                print("Event saved successfully!")
            } catch {
                print("Failed to save event: \(error.localizedDescription)")
            }
        }

    func checkCalendarAccess(add event: Event, alertMessage: Binding<String>, showAlert: Binding<Bool>) {
            let status = EKEventStore.authorizationStatus(for: .event)

            switch status {
            case .notDetermined:
                // Request access if not determined
                eventStore.requestAccess(to: .event) { granted, error in
                    DispatchQueue.main.async {
                        if granted {
                            alertMessage.wrappedValue = "Access granted to your calendar!"
                            DispatchQueue.main.async {
                                createEvent(eventt: event)
                            }
                        } else {
                            alertMessage.wrappedValue = "Access denied. Please enable calendar access in Settings."
                        }
                        showAlert.wrappedValue = true

                    }
                }
            case .authorized:
                // Access already granted
                alertMessage.wrappedValue = "You already have calendar access."
                showAlert.wrappedValue = true
            case .denied, .restricted:
                // Access denied or restricted
                alertMessage.wrappedValue = "Calendar access is restricted or denied. Please enable it in Settings."
                showAlert.wrappedValue = true
            default:
                alertMessage.wrappedValue = "Unknown calendar authorization status."
                showAlert.wrappedValue = true
            }
        }
}
