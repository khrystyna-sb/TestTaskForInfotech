//
//  CitiesProvider.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 24.09.2022.
//

import Foundation
import SQLite

class CitiesProvider {
    
    static var table = Table("cities")
    
    static let id = Expression<Int>("id")
    static let name = Expression<String>("name")
    static let country = Expression<String>("country")
    static let state = Expression<String>("state")
    static let lon = Expression<Double>("lon")
    static let lat = Expression<Double>("lat")
    
    static func createTable() {
        guard let database = SQLiteDatabase.shared.database else { fatalError("Datastore connection error") }
        
        do {
            try database.run(table.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(country)
                table.column(state)
                table.column(lon)
                table.column(lat)
            })
        } catch {
            print("Table already exists: \(error)")
        }
    }
    
    static func insertRow(with city: City) {
        guard let database = SQLiteDatabase.shared.database else {
            print("Datastore connection error")
            return
        }
        do {
            try database.run(table.insert(
                id <- city.id,
                name <- city.name,
                country <- city.country,
                state <- city.state,
                lon <- city.coord.lon,
                lat <- city.coord.lat))
        } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("Insert row failed: \(message), in \(String(describing: statement))")
        } catch {
            print("Insert row failed: \(error)")
        }
    }
    
    static func defaultCities() -> [City]? {
        
        guard let database = SQLiteDatabase.shared.database else {
            print("Datastore connection error")
            return nil
        }
        
        var cities = [City]()
        
        do {
            for row in try database.prepare(table.limit(100)) {
                let rowId = row[id]
                let rowName = row[name]
                let rowCountry = row[country]
                let rowState = row[state]
                let rowLontitude = row[lon]
                let rowLatitude = row[lat]
                
                let city = City(id: rowId, name: rowName, country: rowCountry, state: rowState, coord: Coordinates(lon: rowLontitude, lat: rowLatitude))
                
                cities.append(city)
            }
        } catch {
            print("Present row erros: \(error)")
        }
        
        return cities
    }
    
    static func filteredCities(searchText: String) -> [City]? {
        
        guard let database = SQLiteDatabase.shared.database else {
            print("Datastore connection error")
            return nil
        }
        
        var cities = [City]()
        
        do {
            for row in try database.prepare(table.filter(name.like("\(searchText)%")).limit(10)) {
                let rowId = row[id]
                let rowName = row[name]
                let rowCountry = row[country]
                let rowState = row[state]
                let rowLontitude = row[lon]
                let rowLatitude = row[lat]
                
                let city = City(id: rowId, name: rowName, country: rowCountry, state: rowState, coord: Coordinates(lon: rowLontitude, lat: rowLatitude))
                
                cities.append(city)
            }
        } catch {
            print("Present row erros: \(error)")
        }
        
        return cities
    }
}

