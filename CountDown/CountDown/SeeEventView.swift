//
//  SeeEventView.swift
//  CountDown
//
//  Created by Sirarpi Bayramyan on 16.01.25.
//

import SwiftUI

struct SeeEventView: View {

    @ObservedObject var viewModel: CreateNewEventViewModel
    @Binding private var showDelete: Bool
    @EnvironmentObject var tabState: TabState
    @Environment(\.dismiss) var dismiss
    @State private var countdown = ""



    init(viewModel: CreateNewEventViewModel, showDelete: Binding<Bool> = .constant(false)) {
        self.viewModel = viewModel
        self._showDelete = showDelete
    }

    var body: some View {
        VStack(spacing: 16){

            ZStack {
                Circle()
                    .fill(.blue)
                    .opacity(0.35)
                    .frame(maxWidth: 200)
                Text(viewModel.emojy)
                    .font(.system(size: 100))
            }

            Text(viewModel.name)
                .font(.headline)

            Text("Date: \(viewModel.date.formatted(date: .abbreviated, time: .shortened))")
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


            HStack {
                Text("Date: \(viewModel.date.formatted(date: .complete, time: .complete))")
                Spacer()
            }

            Spacer()

            if showDelete {
                Button(action: {
                    print("Delete")
                    dismiss()
                    tabState.selectedTab = 0
                }, label: {
                    Text("Delete")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
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
        countdown = viewModel.timeRemaining()

    }

    private func startCountdownTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            updateCountdown()
        }
    }
}

#Preview {
    SeeEventView(viewModel: CreateNewEventViewModel(event: Event(name: "Wedding", emojy: "🌸", date: Date()+3000, notes: "happy")))
}
