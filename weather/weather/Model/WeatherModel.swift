//
//  WeatherModel.swift
//  weather
//
//  Created by Ruben on 26/3/24.
//

import Foundation

struct WeatherModel {
    let city: String
    let weather: String
    let description: String
    let iconURL: URL?
    let currentTemperature: String
    let minTemperature: String
    let maxTemperature: String
    let humidity: String
    let sunset: Date
    let sunrise: Date
    // esta será la mostrada mientras se cargan los datos y realiza la petición HTTP
    static let empty: WeatherModel = .init(city: "No City", weather: "No Weather", description: "No Description", iconURL: nil, currentTemperature: "0º", minTemperature: "0º Min", maxTemperature: "0º Max", humidity: "0%", sunset: .now, sunrise: .now)
    
}
