//
//  WeatherViewModel.swift
//  weather
//
//  Created by Ruben on 26/3/24.
//

import Foundation

// https://api.openweathermap.org/data/2.5/weather?q=jaen&appid=71c3e78149e90edcb26b5c8bf57708fa&units=metric&lang=es&ref=swiftbeta.com

final class WeatherViewModel {
    
    /*
     LLamamos al endpoint http de tiempo para la ciudad pasada por parametro
     y convertimos a json
     */
    func getWeather(city: String) async {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=71c3e78149e90edcb26b5c8bf57708fa&units=metric&lang=es&ref=swiftbeta.com")
        do {
            async let (data, _) =  try await URLSession.shared.data(from: url!)
            let dataModel = try! await JSONDecoder().decode(WeatherResponseDataModel.self, from: data)
            print(dataModel)
        } catch {
            print(error.localizedDescription)
        }
    }
}
