//
//  EventsViewModel.swift
//  CountDown
//
//  Created by Sirarpi Bayramyan on 16.01.25.
//

import Foundation

class EventsViewModel: ObservableObject {

    @Published var events: [Event] = []
    

    var service = UserDefaultsEventStorageService()
    init() {
        let event = Event(name: "bb", emojy: "love", date: .now, notes: "vvv")
        self.events = [event] //service.fetch

    }

    func onAppear() {
        service.fetchEvents()

    }




}
