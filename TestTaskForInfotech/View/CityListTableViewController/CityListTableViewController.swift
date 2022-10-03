//
//  ViewController.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 29.08.2022.
//

import UIKit

final class CityListTableViewController: UITableViewController {
    
    private enum Constants {
        static let heightForRow: CGFloat = 90
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var cities: [CityViewModel] = []
    private var filteredCities: [CityViewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCities()
        setSubViews()
    }
    
    private func setSubViews() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = self.searchController.searchBar
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
    }
    
    
    private func getCities() {
        guard let defaultCities = SQLiteCommands.defaultCities() else { return }
        let result: [CityViewModel] = defaultCities
            .enumerated()
            .compactMap { tuple in
                let path = tuple.offset.isMultiple(of: 2) ? Path.evenUrl : Path.oddUrl
                return CityViewModel(name: tuple.element.name, url: path, coordinates: tuple.element.coord)
            }
        self.cities = result
    }
    
    private func filterCitiesBySearchText(_ searchText: String) {
        guard let filteredCities = SQLiteCommands.filteredCities(searchingText: searchText) else { return }
        let result: [CityViewModel] = filteredCities
            .enumerated()
            .compactMap { tuple in
                let path = tuple.offset.isMultiple(of: 2) ? Path.evenUrl : Path.oddUrl
                return CityViewModel(name: tuple.element.name, url: path, coordinates: tuple.element.coord)
            }
        self.filteredCities = result
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities?.count ?? cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else { return UITableViewCell() }
        let city = filteredCities?[indexPath.row] ?? cities[indexPath.row]
        cell.configure(with: city)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightForRow
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coordinates = filteredCities?[indexPath.row].coordinates ?? cities[indexPath.row].coordinates
        let vc = WeatherViewController(coordinates: coordinates)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CityListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterCitiesBySearchText(searchText)
        tableView.reloadData()
    }
}
