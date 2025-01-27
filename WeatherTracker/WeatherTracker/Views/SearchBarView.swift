//
//  SearchBarView.swift
//  WeatherTracker
//
//  Created by Sirarpi Bayramyan on 26.01.25.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var query: String
    var onSearch: (() -> Void)?
    
    var body: some View {
        HStack {
            TextField("Search location", text: $query)
                .padding(12)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                .padding(.horizontal)
                .overlay(
                    HStack {
                        Spacer()
                        Button(action: {
                            onSearch?()
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray.opacity(0.75))
                                .padding()
                        }
                        .padding(.trailing, 12)
                    }
                )
            
        }
        .padding(.top)
    }
}

#Preview {
    @State var query = "Pune"
    return SearchBarView(query: $query)
}
