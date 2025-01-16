//
//  CreateEventView.swift
//  CountDown
//
//  Created by Sirarpi Bayramyan on 16.01.25.
//

import SwiftUI

struct CreateEventView: View {

    @Binding var selectedTab: Int
    @State private var showAlert = false
    @State private var alertMessage = ""
    @StateObject private var viewModel = CreateNewEventViewModel()

    init(selectedTab: Binding<Int>) {
        self._selectedTab = selectedTab
    }

    var body: some View {
        VStack(spacing: 16){
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
                Text(viewModel.emojy)
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
                TextField(viewModel.emojy, text: $viewModel.emojy)
                    .padding(.horizontal)
                    .textFieldStyle(.roundedBorder)

            }

            HStack {
                DatePicker("Event Date", selection: $viewModel.date)
            }

            Spacer()

            Button(action: {
                print("save")
                viewModel.saveEvent(alertMessage: $alertMessage, showAlert: $showAlert)
                if alertMessage == "Event created successfully!" {
                    selectedTab = 0// Navigate to the desired tab
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

            Spacer()

        }
        .navigationTitle("event")
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Calendar Access"),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("OK")))
        }

    }
}

#Preview {
    CreateEventView(selectedTab: .constant(1))
}
