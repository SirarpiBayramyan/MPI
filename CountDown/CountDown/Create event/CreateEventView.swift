//
//  CreateEventView.swift
//  CountDown
//
//  Created by Sirarpi Bayramyan on 16.01.25.
//

import SwiftUI

struct CreateEventView: View {
    @EnvironmentObject var tabState: TabState 
    @State private var showAlert = false
    @State private var alertMessage = ""
    @ObservedObject private var viewModel = CreateNewEventViewModel()
    @State private var navigateToSeeEvents = false // State for navigation


    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HStack {
                    Text("New Event")
                        .font(.title)
                        .bold()
                    Spacer()
                }

                ZStack {
                    Circle()
                        .fill(.blue)
                        .opacity(0.35)
                    Text(viewModel.emoji)
                        .font(.system(size: 100))
                }

                HStack {
                    Text("Event Name:")
                    Spacer()
                    TextField("name", text: $viewModel.name)
                        .padding(.horizontal)
                        .textFieldStyle(.roundedBorder)
                }

                HStack {
                    Text("Emoji :")
                    Spacer()
                    TextField(viewModel.emoji, text: $viewModel.emoji)
                        .padding(.horizontal)
                        .textFieldStyle(.roundedBorder)
                }

                HStack {
                    DatePicker("Event Date", selection: $viewModel.date, displayedComponents: [.date, .hourAndMinute])

                }

                Spacer()

                Button(action: {
                    viewModel.saveEvent(alertMessage: $alertMessage, showAlert: $showAlert)
                        // if alertMessage == "Event created successfully!" {
                        DispatchQueue.main.async {
                            navigateToSeeEvents = true // Navigate to SeeEventView
                       // }
                    }
                }, label: {
                    Text("Save")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                })
                .disabled(viewModel.isSaveDisabled)
// TODO: Add notes
                Spacer()
            }
            .hideKeyboardOnTap()
            .padding()
            .navigationDestination(isPresented: $navigateToSeeEvents) {
                SeeEventView(viewModel: EventViewModel(event: Event(name: viewModel.name, emoji: viewModel.emoji, date: viewModel.date, notes: viewModel.notes)), showDelete: .constant(false))

            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Event Status"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

import SwiftUI

extension View {
    func hideKeyboardOnTap() -> some View {
        self.gesture(
            TapGesture().onEnded {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        )
    }
}


#Preview {
    CreateEventView()
}
