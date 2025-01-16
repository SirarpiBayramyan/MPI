//
//  MainView.swift
//  CountDown
//
//  Created by Sirarpi Bayramyan on 16.01.25.
//

import SwiftUI

class TabState: ObservableObject {
    @Published var selectedTab: Int = 0
}

struct MainView: View {

    @StateObject private var tabState = TabState()

    var body: some View {
        TabView(selection: $tabState.selectedTab) {
            EventsView()
                .tabItem {
                    Label("Eventes", systemImage: "list.bullet.clipboard")
                }
                .tag(0)

            CreateEventView()
                .tabItem {
                    Label("Create", systemImage: "plus")
                }
                .tag(1)

        }
        .environmentObject(tabState)

    }
}

#Preview {
    MainView()
}
