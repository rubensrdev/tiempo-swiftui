//
//  ContentView.swift
//  weather
//
//  Created by Ruben on 26/3/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var weatherViewModel = WeatherViewModel()
    @State var cityToSearh: String = "jaen"
    
    var body: some View {
        ZStack {
            VStack {
                Text(weatherViewModel.weatherModel.city)
                    .foregroundStyle(.white)
                    .font(.system(size: 70))
                Text(weatherViewModel.weatherModel.description)
                    .foregroundStyle(.white)
                    .font(.headline)
                    .padding(.bottom, 8)
                HStack {
                    if let url = weatherViewModel.weatherModel.iconURL {
                        AsyncImage(url: url) { image in
                            image
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    Text(weatherViewModel.weatherModel.currentTemperature)
                        .font(.system(size: 70))
                        .foregroundStyle(.white)
                }
                .padding(.top, -20)
                HStack(spacing: 14) {
                    Label(weatherViewModel.weatherModel.maxTemperature, systemImage: "thermometer.sun.fill")
                    Label(weatherViewModel.weatherModel.minTemperature, systemImage: "thermometer.snowflake")
                }
                .symbolRenderingMode(.multicolor)
                .foregroundStyle(.white)
                Divider()
                    .foregroundStyle(.white)
                    .padding()
                Label(weatherViewModel.weatherModel.humidity, systemImage: "humidity.fill")
                    .symbolRenderingMode(.multicolor)
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.top, 32)
        }
        .background(
            LinearGradient(colors: [.blue, .indigo, .mint], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .task {
            await weatherViewModel.getWeather(city: cityToSearh)
        }
    }
}

#Preview {
    ContentView()
}
