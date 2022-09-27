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
        guard let fileURL = Bundle.main.url(forResource: "city_list", withExtension: "json") else { return }
        do {
            database = try Connection(fileURL.path)
        } catch {
            fatalError("Failed to create connection to database. \(error)")
        }
    }
    
    //Creating Table
    func createTable() {
        SQLiteCommands.createTable()
    }
}
