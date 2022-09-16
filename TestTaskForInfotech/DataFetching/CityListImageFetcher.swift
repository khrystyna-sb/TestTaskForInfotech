//
//  NetworkManager.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 16.09.2022.
//

import Foundation
import UIKit

class CityListImageFetcher {
    
    func getOddImage(complition: @escaping (UIImage) -> Void) {
        let url = URL(string: "https://infotech.gov.ua/storage/img/Temp1.png")
        if let url = url {
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    if let image = UIImage(data: data) {
                        complition(image)
                    }
                }
            }
        }
    }
    
    func getEvenImage(complition: @escaping (UIImage) -> Void) {
        let url = URL(string: "https://infotech.gov.ua/storage/img/Temp3.png")
        if let url = url {
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    if let image = UIImage(data: data) {
                        complition(image)
                    }
                }
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
