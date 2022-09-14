//
//  ViewController.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 29.08.2022.
//

import UIKit

class CityListTableViewController: UITableViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let viewModel = CityListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.listOfCities.count > 30 {
            return 30
        } else {
            return viewModel.listOfCities.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let city = viewModel.listOfCities[indexPath.row]
        cell.textLabel?.text = city.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let repositoryDetailsViewController = RepositoryDetailsViewController()
//        repositoryDetailsViewController.githubRepositoryResult = viewModel?.githubRepositoryResults?.items[indexPath.row]
//        navigationController?.pushViewController(repositoryDetailsViewController, animated: true)
    }
}

extension CityListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
}




