//
//  CityDataModel.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 29.08.2022.
//

import Foundation

struct City:  Codable {
    let id: Int
    let name: String
    let country: String
    let state: String
    let coord: Coordinates
}

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}


