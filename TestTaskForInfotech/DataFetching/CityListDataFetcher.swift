//
//  CityListDataFetcher.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 29.08.2022.
//

import Foundation

class CityListDataFetcher {
    
    func loadJson(fileName: String) -> [City]? {
       let decoder = JSONDecoder()
        
       guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let city = try? decoder.decode([City].self, from: data)
       else {
            return nil
       }
       return city
    }
}

