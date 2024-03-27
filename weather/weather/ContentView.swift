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
                TextField("Ciudad a buscar", text: $cityToSearh)
                    .keyboardType(.default)
                    .autocorrectionDisabled()
                    .padding(10)
                    .font(.headline)
                    .background(Color.teal.opacity(0.3))
                    .cornerRadius(6)
                    .padding(.horizontal, 60)
                    .padding(.bottom, 20)
                    .foregroundStyle(.white)
                Button(
                    action: {
                        print("Pulsado botón buscar con ciudad -> \(cityToSearh)")
                        Task {
                            await weatherViewModel.getWeather(city: cityToSearh)
                        }
                    }
                    ,
                    label:{
                        Text("Buscar")
                            .foregroundStyle(.white)
                            .background(Color.teal.opacity(0.3))
                            .font(.title2)
                    }
                )
                Divider()
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
                HStack(spacing: 32) {
                    VStack {
                        Image(systemName: "sunrise.fill")
                            .symbolRenderingMode(.multicolor)
                        Text(weatherViewModel.weatherModel.sunrise, style: .time)
                    }
                    VStack {
                        Image(systemName: "sunset.fill")
                            .symbolRenderingMode(.multicolor)
                        Text(weatherViewModel.weatherModel.sunset, style: .time)
                    }
                }
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
    }
}

#Preview {
    ContentView()
}
