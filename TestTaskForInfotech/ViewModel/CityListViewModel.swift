//
//  CityListViewModel.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 29.08.2022.
//

import Foundation
import UIKit

class CityListViewModel {
    
    private let jsonName = "city_list copy"
    private let cityDataFetcher = CityListDataFetcher()
    private let сityListImageFetcher = CityListImageFetcher()
    private let mockListOfCities = [City(id: 1, name: "some city", country: "some counrty", state: "some state", coord: Coordinates(lon: 123, lat: 123))]
    
    var listOfCities: [City] {
        return cityDataFetcher.loadJson(fileName: jsonName) ?? mockListOfCities
    }

    var oddImage: UIImage? 
    var evenImage: UIImage?
    
    
    init() {
        setOddImage()
        setEvenImage()
    }
    
    private func setOddImage() {
        сityListImageFetcher.getOddImage { [weak self] image in
            self?.oddImage = image
        }
    }
    
    private func setEvenImage() {
        сityListImageFetcher.getEvenImage { [weak self] image in
            self?.evenImage = image
        }
    }
}
