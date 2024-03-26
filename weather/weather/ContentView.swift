//
//  ContentView.swift
//  weather
//
//  Created by Ruben on 26/3/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var weatherViewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Text(weatherViewModel.weatherResponseDataModel?.city ?? "No city")
                    .foregroundStyle(.white)
                    .font(.system(size: 70))
                Text(weatherViewModel.weatherResponseDataModel?.weather.first?.description ?? "No description")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .padding(.bottom, 8)
                HStack {
                    if let iconURL = weatherViewModel.weatherResponseDataModel?.weather.first?.iconURLString, let url = URL(string: "http://openweathermap.org/img/wn/\(iconURL)@2x.png") {
                        AsyncImage(url: url) { image in
                            image
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    Text("\(weatherViewModel.weatherResponseDataModel?.temperature.currentTemperature ?? 0.0)º")
                        .font(.system(size: 70))
                        .foregroundStyle(.white)
                }
                .padding(.top, -20)
                HStack(spacing: 14) {
                    Label("\(weatherViewModel.weatherResponseDataModel?.temperature.maxTemperature ?? 0.0)º", systemImage: "thermometer.sun.fill")
                    Label("\(weatherViewModel.weatherResponseDataModel?.temperature.minTemperature ?? 0.0)º", systemImage: "thermometer.snowflake")
                }
                .symbolRenderingMode(.multicolor)
                .foregroundStyle(.white)
                Divider()
                    .foregroundStyle(.white)
                    .padding()
                Label("\(weatherViewModel.weatherResponseDataModel?.temperature.humidity ?? 0) %", systemImage: "humidity.fill")
                    .symbolRenderingMode(.multicolor)
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.top, 32)
        }
        .background(
            LinearGradient(colors: [.blue, .purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .task {
            await weatherViewModel.getWeather(city: "jaen")
        }
    }
}

#Preview {
    ContentView()
}
