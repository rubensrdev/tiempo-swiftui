//
//  WeatherViewModel.swift
//  weather
//
//  Created by Ruben on 26/3/24.
//

import Foundation

// https://api.openweathermap.org/data/2.5/weather?q=jaen&appid=71c3e78149e90edcb26b5c8bf57708fa&units=metric&lang=es&ref=swiftbeta.com

final class WeatherViewModel: ObservableObject{
    
    @Published var weatherModel: WeatherModel = .empty
    private let weatherModelMapper: WeatherModelMapper = WeatherModelMapper()
    
    /*
     LLamamos al endpoint http de tiempo para la ciudad pasada por parametro
     y convertimos a json
     */
    func getWeather(city: String) async {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=71c3e78149e90edcb26b5c8bf57708fa&units=metric&lang=es&ref=swiftbeta.com")
        do {
            // petición
            async let (data, _) =  try await URLSession.shared.data(from: url!)
            // mapeo
            let dataModel = try! await JSONDecoder().decode(WeatherResponseDataModel.self, from: data)
            // asignación
            DispatchQueue.main.async {
                self.weatherModel = self.weatherModelMapper.mapDataModelToModel(dataModel: dataModel )
            }
        
        } catch {
            print(error.localizedDescription)
        }
    }
}
