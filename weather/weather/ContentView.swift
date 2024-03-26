//
//  ContentView.swift
//  weather
//
//  Created by Ruben on 26/3/24.
//

import SwiftUI

struct ContentView: View {
    
    private let weatherViewModel = WeatherViewModel()
    
    var body: some View {
        Text("Hello World!")
            .task {
                await weatherViewModel.getWeather(city: "jaen")
            }
    }
}

#Preview {
    ContentView()
}
