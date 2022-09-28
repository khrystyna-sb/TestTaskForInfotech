//
//  WeatherViewModel.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 27.09.2022.
//

import Foundation

struct WeatherViewModel {
    let name: String
    let description: String
    let currentTemperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let humidity: Int
    let windSpeed: Double
    let coordinates: Coordinates
    
    static func create(weatherModel: WeatherDataModel) -> Self {
        return .init(name: weatherModel.name,
                     description: weatherModel.weather[0].description,
                     currentTemperature: weatherModel.main.temp,
                     minTemperature: weatherModel.main.temp_min,
                     maxTemperature: weatherModel.main.temp_max,
                     humidity: weatherModel.main.humidity,
                     windSpeed: weatherModel.wind.speed,
                     coordinates: weatherModel.coord)
    }
}

