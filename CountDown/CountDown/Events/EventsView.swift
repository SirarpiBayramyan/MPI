//
//  EventView.swift
//  CountDown
//
//  Created by Sirarpi Bayramyan on 16.01.25.
//

import SwiftUI

struct EventsView: View {

    @EnvironmentObject var tabState: TabState // Access environment object
    @StateObject var viewModel = EventsViewModel()


    var body: some View {
        if viewModel.events.isEmpty {
            emptyContent
        } else {
            listContent
        }
    }

    @ViewBuilder
    private var emptyContent: some View {
        VStack {
            Spacer()
            Text("There are no events, you can create new ones")
            Spacer()
            Button {
                print("Create")
                tabState.selectedTab = 1
            } label: {
                Text("Create")
                    .font(.footnote)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }

            Spacer()

        }
        .padding()
    }

    @ViewBuilder
    private var listContent: some View {
        NavigationView {
            List {
                ForEach($viewModel.events, id: \.self) { event in
                    VStack(alignment: .leading) {
                        Text(event.name.wrappedValue + event.emojy.wrappedValue)
                            .font(.headline)
                        Text("date: \(event.date.wrappedValue)")
                            .font(.caption)
                    }
                    .onTapGesture {
                        print("eventScreen")
                    }
                }
            }
            .navigationTitle("Events")
        }
    }
}

#Preview {
    EventsView()
}
