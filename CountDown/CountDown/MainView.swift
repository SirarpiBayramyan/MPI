//
//  MainView.swift
//  CountDown
//
//  Created by Sirarpi Bayramyan on 16.01.25.
//

import SwiftUI

struct MainView: View {

    @State private var selectedTab = 0

    var body: some View {
        TabView {
            EventsView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Eventes", systemImage: "list.bullet.clipboard")
                }
                .tag(0)

            CreateEventView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Create", systemImage: "plus")
                }
                .tag(1)


        }

    }
}

#Preview {
    MainView()
}
