//
//  WeatherDataModel.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 27.09.2022.
//

import Foundation

struct WeatherDataModel: Decodable {
    let coord: Coordinates
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let name: String
}

struct Weather: Decodable {
    let description: String
}

struct Main: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
    
}

struct Wind: Decodable {
    let speed: Double
    let deg: Double?
}
