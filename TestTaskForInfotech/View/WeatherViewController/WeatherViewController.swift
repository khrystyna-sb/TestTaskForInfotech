//
//  WeatherViewController.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 27.09.2022.
//

import UIKit
import MapKit

final class WeatherViewController: UIViewController, MKMapViewDelegate {
    
    private enum Constants {
        static let stackViewIdent: CGFloat = 20
    }
    
    private let mapView = MKMapView()
    private let weatherApi: WeatherApiIntegrationProtocol
    private let coordinates: Coordinates
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let descriptionLabel = UILabel()
    private let currentTemperatureLabel = UILabel()
    private let minTemperatureLabel = UILabel()
    private let maxTemperature = UILabel()
    private let humidityLabel = UILabel()
    private let windSpeedLabel = UILabel()
    

    init(coordinates: Coordinates) {
        self.weatherApi = WeatherApiIntegration()
        self.coordinates = coordinates
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        containerStackViewLayout()
        mapViewLayout()
        recieveWeatherModel()
    }
    
    private func fillSubviews(viewModel: WeatherViewModel) {
        setupMapView(with: viewModel.coordinates)
        descriptionLabel.text = viewModel.description + " in " + viewModel.name
        currentTemperatureLabel.text = "Current temperature: \(viewModel.currentTemperature)"
        minTemperatureLabel.text = "Min temp: \(viewModel.minTemperature)"
        maxTemperature.text = "Max temp: \(viewModel.maxTemperature)"
        humidityLabel.text = "Humidity: \(viewModel.humidity)"
        windSpeedLabel.text = "Speed of wind: \(viewModel.windSpeed)"
    }

    private func recieveWeatherModel() {
        self.weatherApi.loadWeather(coordinates: self.coordinates) { [weak self] result in
            
            
            switch result {
            case .success(let model):
                
                // dispatch main async
                self?.fillSubviews(viewModel: WeatherViewModel.create(weatherModel: model))
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupMapView(with model: Coordinates) {
        let latitude = model.lat
        let longitude = model.lon
        mapView.delegate = self
        mapView.setCenter(CLLocationCoordinate2D(latitude: latitude, longitude: longitude), animated: true)
        
        let latitudeDelta = CLLocationDegrees(0.7)
        let span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: latitudeDelta)
        let regionCenter = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegion(center: regionCenter, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    private func mapViewLayout() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func containerStackViewLayout() {
        view.addSubview(containerStackView)
        containerStackView.addArrangedSubview(descriptionLabel)
        containerStackView.addArrangedSubview(currentTemperatureLabel)
        containerStackView.addArrangedSubview(minTemperatureLabel)
        containerStackView.addArrangedSubview(maxTemperature)
        containerStackView.addArrangedSubview(humidityLabel)
        containerStackView.addArrangedSubview(windSpeedLabel)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: view.centerYAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackViewIdent),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.stackViewIdent),
            containerStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
