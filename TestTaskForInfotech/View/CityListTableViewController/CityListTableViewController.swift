//
//  ViewController.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 29.08.2022.
//

import UIKit

class CityListTableViewController: UITableViewController {
    
    private var viewModel: CityListTableViewModel
    
    init(viewModel: CityListTableViewModel = CityListTableViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private enum Constants {
        static let heightForRow: CGFloat = 90
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubViews()
    }
    
    private func setSubViews() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = self.searchController.searchBar
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else { return UITableViewCell() }
        
        if let city = viewModel.cities?[indexPath.row] {
            cell.configure(with: city)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightForRow
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let coordinates = viewModel.cities?[indexPath.row].coordinates {
            let vc = WeatherViewController(coordinates: coordinates)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CityListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchWithText(searchText: searchText)
        tableView.reloadData()
    }
}
