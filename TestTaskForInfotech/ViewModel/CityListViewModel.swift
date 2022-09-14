//
//  CityListViewModel.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 29.08.2022.
//

import Foundation

class CityListViewModel {
    
    private let jsonName = "city_list copy"
    private let cityDataFetcher = CityListDataFetcher()
    private let mockListOfCities = [City(id: 1, name: "some city", country: "some counrty", state: "some state", coord: Coordinates(lon: 123, lat: 123))]
    
    var listOfCities: [City] {
        return cityDataFetcher.loadJson(fileName: jsonName) ?? mockListOfCities
    }
    
}
