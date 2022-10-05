//
//  CityListTableViewModel.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 05.10.2022.
//

import Foundation

class CityListTableViewModel {
    
    var cities: [CityViewModel]?
    var onCitiesUpdate: (() -> Void)?
    
    init() {
        searchDefaultCities()
    }
    
    func searchWithText(searchText: String) {
        getCitiesFromCitiesProvider(searchText: searchText)
    }
    
    private func searchDefaultCities(){
        guard let defaultCities = CitiesProvider.defaultCities() else { return }
        let result: [CityViewModel] = defaultCities
            .enumerated()
            .compactMap { tuple in
                let path = tuple.offset.isMultiple(of: 2) ? Path.evenUrl : Path.oddUrl
                return CityViewModel(name: tuple.element.name, url: path, coordinates: tuple.element.coord)
            }
        self.cities = result
    }

    private func getCitiesFromCitiesProvider(searchText: String) {
        guard let filteredCities = CitiesProvider.filteredCities(searchText: searchText) else { return }
        let result: [CityViewModel] = filteredCities
            .enumerated()
            .compactMap { tuple in
                let path = tuple.offset.isMultiple(of: 2) ? Path.evenUrl : Path.oddUrl
                return CityViewModel(name: tuple.element.name, url: path, coordinates: tuple.element.coord)
            }
            self.cities = result
            self.onCitiesUpdate?()
    }
}
