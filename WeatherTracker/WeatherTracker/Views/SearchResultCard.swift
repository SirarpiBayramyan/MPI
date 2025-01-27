//
//  SearchResultCard.swift
//  WeatherTracker
//
//  Created by Sirarpi Bayramyan on 26.01.25.
//

import SwiftUI

struct SearchResultCard: View {

    var weather: WeatherModel
    var onTap: () -> Void // Closure to handle the tap action

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(weather.location.name)
                    .font(.headline)
                Text("\(Int(weather.current.tempC))°")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }

            Spacer()

            // Weather icon
            AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
            } placeholder: {
                Image("cloudy") // Placeholder image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.1))
        )
        .onTapGesture {
            onTap() // Call the onTap action
        }
    }
}


#Preview {
    SearchResultCard(
        weather: WeatherModel(
            location: Location(name: "Mumbai"),
            current: CurrentWeather(
                tempC: 28,
                condition: WeatherCondition(text: "Sunny", icon: "/weather/64x64/day/113.png"),
                humidity: 60,
                uv: 5.0,
                feelslikeC: 30.0
            )
        )
    ) {
        print("Card tapped!")
    }
    .padding()
    .previewLayout(.sizeThatFits)
}
