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
    @Published var notes: String = ""


    private var calendarServie = CalendarEventService()

    func saveEvent(alertMessage: Binding<String>, showAlert: Binding<Bool>) {
        let event = Event(name: name, emojy: emojy, date: date, notes: notes)

        calendarServie.checkCalendarAccess(add: event, alertMessage: alertMessage, showAlert: showAlert)
    }

    


}
