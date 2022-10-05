//
//  SQLiteDatabase.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 24.09.2022.
//

import Foundation
import SQLite

class SQLiteDatabase {
    
    static let shared = SQLiteDatabase()
    var database: Connection?
    
    private init() {
        guard let dbPath = Bundle.main.path(forResource: "db", ofType: "sqlite") else { return }
        do {
            print("copy SQLFile from \(dbPath)")
            database = try Connection(dbPath)
        } catch {
            database = nil
            fatalError("Failed to create connection to database. \(error)")
        }
    }
    
    //Creating Table
    func createTable() {
        CitiesProvider.createTable()
    }
}
