//
//  WeatherApiIntegration.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 27.09.2022.
//

import Foundation

struct Constants {
    static let apiKey = "f161c4f841f75fe26cace3cb532e3b4b"
}

protocol WeatherApiIntegrationProtocol {
    func loadWeather(coordinates: Coordinates, completion: @escaping (Result<WeatherDataModel, Error>) -> Void)
}

class WeatherApiIntegration: WeatherApiIntegrationProtocol {
    
    private let networkService: NetworkServiceProtocol
    private var dataTask: URLSessionDataTask?
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func loadWeather(coordinates: Coordinates, completion: @escaping (Result<WeatherDataModel, Error>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.lat)&lon=\(coordinates.lon)&appid=\(Constants.apiKey)") else { return }
        self.dataTask = self.networkService.perform(request: URLRequest(url: url), completion: { [weak self] result in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data, _):
                    completion(self.decode(data))
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
    
    private func decode<Value: Decodable>(_ data: Data?) -> Result<Value, Error> {
        do {
            guard let data = data else {
                let error: Error = "error: no data" as! Error
                return .failure(error)
            }
            let value = try JSONDecoder().decode(Value.self, from: data)
            return .success(value)
        } catch {
            return .failure(error)
        }
    }
}
