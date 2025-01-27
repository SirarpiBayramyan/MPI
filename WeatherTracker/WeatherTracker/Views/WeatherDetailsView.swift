//
//  WeatherDetailsView.swift
//  WeatherTracker
//
//  Created by Sirarpi Bayramyan on 26.01.25.
//

import SwiftUI

struct WeatherDetailsView: View {
    var weather: WeatherModel

    var body: some View {
        VStack(spacing: 20) {
            // Weather Icon and City Name
            VStack(spacing: 8) {
                if let iconURL = URL(string: "https:\(weather.current.condition.icon)") {
                    AsyncImage(url: iconURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                    } placeholder: {
                        ProgressView() // Placeholder while the image loads
                    }
                } else {
                    Image(systemName: "questionmark.circle") // Fallback for invalid URL
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                }

                HStack {
                    Text(weather.location.name)
                        .font(.system(size: 24, weight: .bold))

                    Image(systemName: "location.fill")
                        .foregroundColor(.gray)
                }
            }

            // Temperature
            Text("\(Int(weather.current.tempC))°")
                .font(.system(size: 72, weight: .bold))
                .foregroundColor(.black)

            // Additional Details
            HStack(spacing: 16) {
                weatherDetailView(title: "Humidity", value: "\(weather.current.humidity)%")
                weatherDetailView(title: "UV", value: "\(String(format: "%.1f", weather.current.uv))")
                weatherDetailView(title: "Feels Like", value: "\(Int(weather.current.feelslikeC))°")
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.gray.opacity(0.1))
            )
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 20)
    }

    private func weatherDetailView(title: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            Text(value)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
        }
    }
}


#Preview {
    WeatherDetailsView(weather: WeatherModel(
        location: Location(name: "Hyderabad"),
        current: CurrentWeather(
            tempC: 31,
            condition: WeatherCondition(text: "Sunny", icon: "sun.max.fill"),
            humidity: 20,
            uv: 4.0,
            feelslikeC: 38
        )
    ))
    .previewLayout(.sizeThatFits)
    .padding()
}
