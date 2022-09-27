//
//  ViewController.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 29.08.2022.
//

import UIKit

class CityListTableViewController: UITableViewController {
    
    private enum Constants {
        static let heightForRow: CGFloat = 90
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var cities: [CityViewModel] = []
    private var filteredCities: [CityViewModel]?
    private let jsonParser: JSONParserProtocol?
    
    init() {
        self.jsonParser = JSONParser()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        guard let jsonParser = jsonParser else { return }
        let result = jsonParser.parseJSON(file: "city_list")
        switch result {
        case .success(let models):
            let result: [CityViewModel] = models
                .enumerated()
                .compactMap { tuple in
                    let path = tuple.offset.isMultiple(of: 2) ? Path.evenUrl : Path.oddUrl
                    return CityViewModel(name: tuple.element.name, url: path, coordinates: tuple.element.coord)
            }
            self.cities = result
        case .failure(let error):
            print(error)
        }
    }
    
    private func filterCitiesBySearchText(_ searchText: String) {
        self.filteredCities = self.cities.filter { $0.name.lowercased().contains(searchText.lowercased())}
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
    }
}

extension CityListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterCitiesBySearchText(searchText)
        tableView.reloadData()
    }
}




