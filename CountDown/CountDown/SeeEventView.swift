//
//  emoji.swift
//  CountDown
//
//  Created by Sirarpi Bayramyan on 16.01.25.
//
import SwiftUI

struct SeeEventView: View {
    @ObservedObject var viewModel: EventViewModel
    @Binding var showDelete: Bool
    @EnvironmentObject var tabState: TabState
    @Environment(\.dismiss) var dismiss
    @State private var countdown = ""

    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(.blue)
                    .opacity(0.35)
                    .frame(maxWidth: 200)
                Text(viewModel.event.emoji)
                    .font(.system(size: 100))
            }

            Text(viewModel.event.name)
                .font(.headline)

            Text("Date: \(viewModel.event.date.formatted(date: .abbreviated, time: .shortened))")
            Divider()

            ZStack {
                Rectangle()
                    .fill(.blue)
                    .opacity(0.35)
                    .cornerRadius(30)
                    .frame(height: 100)

                HStack {
                    Text("Time Remaining:")
                        .font(.headline)
                    Spacer()
                    Text(countdown)
                        .font(.body)
                        .bold()
                }
                .padding()
            }

            if viewModel.event.date < Date() {
                Text("This event has already passed.")
                    .foregroundColor(.red)
            }

            Spacer()
            if showDelete {
                Button(action: {
                    viewModel.deleteEvent()
                    dismiss()
                }, label: {
                    Text("Delete")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                })

                Spacer()
            }
            Button(action: {
                dismiss()
                tabState.selectedTab = 0
            }, label: {
                Text("Done")
            })
        }
        .padding()
        .onAppear {
            updateCountdown()
            startCountdownTimer()
        }
    }

    private func updateCountdown() {
        countdown = timeRemaining()
    }

    private func startCountdownTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            updateCountdown()
        }
    }

    func timeRemaining() -> String {
        let now = Date()
        let components = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: now, to: viewModel.event.date)

        guard let days = components.day, let hours = components.hour, let minutes = components.minute, let seconds = components.second else {
            return "Time calculation error"
        }

        return now > viewModel.event.date ? "Event has passed" : "\(days)d \(hours)h \(minutes)m \(seconds)s"
    }
}


#Preview {
    SeeEventView(viewModel: EventViewModel(event: Event(name: "Wedding", emoji: "🌸", date: Date()+3000, notes: "happy")), showDelete: .constant(false))
}


import Foundation

class EventViewModel: ObservableObject {
    @Published var event: Event

    init(event: Event) {
        self.event = event
    }

    func updateEventName(_ newName: String) {
        event.name = newName
    }

    func deleteEvent() {
        UserDefaultsEventStorageService.shared.delete(event: event)
    }
}
