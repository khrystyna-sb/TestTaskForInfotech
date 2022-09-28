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




//{
//    "coord":
//    {
//        "lon":36.3219,
//        "lat":34.9401
//    },
//    "weather": [{
//        "id":800,
//        "main":"Clear",
//        "description":"clear sky",
//        "icon":"01d"
//    }],
//    "base":"stations",
//    "main": {
//        "temp":298.53,
//        "feels_like":298.14,
//        "temp_min":298.53,
//        "temp_max":298.53,
//        "pressure":1012,
//        "humidity":39,
//        "sea_level":1012,
//        "grnd_level":942
//    },
//    "visibility":10000,
//    "wind": {
//        "speed":9.4,
//        "deg":263,
//        "gust":10.58},
//    "clouds": {
//        "all":0
//    },
//    "dt":1664364235,
//    "sys": {
//        "country":"SY",
//        "sunrise":1664335610,
//        "sunset":1664378640
//    },
//    "timezone":10800,
//    "id":2960,
//    "name":"‘Ayn Ḩalāqīm","cod":200
//}
