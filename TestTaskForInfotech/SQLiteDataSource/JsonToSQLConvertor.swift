//
//  JsonToSQLConvertor.swift
//  TestTaskForInfotech
//
//  Created by Khrystyna Matasova on 01.10.2022.
//

import Foundation

// JSON file is too huge for fast getting data from it, therefore we have to convert json to sqlite to optimize fetching data.

// For converting json to sqlite do this step:
// - insert this code to didFinishLaunchingWithOptions;

/* let converter = JsonToSQLConverter.shared.convertJSONToSQL() */

// wait up to 10 minutes, it depens on your computer

// read "inserting completed" massage in console

// - copy file from path in console ("copy SQLFile from...");

// - add it to project in Resources folder.

// Then you can delete json.


class JsonToSQLConverter {
    static let shared = JsonToSQLConverter()
    private let jsonParser: JSONParserProtocol
    
    init() {
        self.jsonParser = JSONParser()
    }
    
    func convertJSONToSQL() {
        let result = jsonParser.parseJSON(file: "city_list")
        switch result {
        case .success(let models):
            let dataBase = SQLiteDatabase.shared
            dataBase.createTable()
            for index in 0..<models.count {
               CitiesProvider.insertRow(with: models[index])
            }
            print("inserting completed")
        case .failure(let error):
            print(error)
        }
    }
}


protocol JSONParserProtocol {
    func parseJSON(file: String) -> Result<[City], AppError>
}

final class JSONParser: JSONParserProtocol {
    
    public func parseJSON(file: String) -> Result<[City], AppError>  {
        if let url = Bundle.main.url(forResource: file, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([City].self, from: data)
                return .success(jsonData)
            } catch {
                return .failure(.unowned(error))
            }
        }
        return .failure(.jsonError)
    }
}

enum AppError: Error {
    
    case jsonError
    case unowned(Error)
    
    var stringDescription: String {
        
        switch self {
        case .jsonError: return "Couldn retrieve data"
        case .unowned(let error): return error.localizedDescription
        }
    }
}



