//
//  JSONParser.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 26.09.2022.
//

import Foundation
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
