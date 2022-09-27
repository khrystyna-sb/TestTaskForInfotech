//
//  SQLiteCommands.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 24.09.2022.
//

import Foundation
import SQLite

class SQLiteCommands {
    
    static var table = Table("cityList")
    
    static let id = Expression<Int>("id")
    static let name = Expression<String>("name")
    static let country = Expression<String>("country")
    static let state = Expression<String>("state")
//    static let coord = Expression<Coordinates>("coord")
    
    static func createTable() {
        guard let database = SQLiteDatabase.shared.database else { fatalError("Datastore connection error") }
        
        do {
            try database.run(table.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(country)
                table.column(state)
//                table.column(coord)
            })
        } catch {
            print("Table already exists: \(error)")
        }
    }

//    static func presentRows(rowAtIndexPath: Int) -> [City]? {
//        guard let database = SQLiteDatabase.shared.database else {
//            print("Datastore connection error")
//            return nil
//        }
//        
// 
//        var cityArray = [City]()
//
//        table = table.order(id.desc)
//        
//        do {
//            for city in try database.prepare(table.limit(50, offset: rowAtIndexPath)) {
//                
//                let city = City(id: city[id], name: city[name], country: city[country], state: city[state])
//                
//                cityArray.append(city)
//            }
//        } catch {
//            print("Present row erros: \(error)")
//        }
//        
//        return cityArray
//    }
}
