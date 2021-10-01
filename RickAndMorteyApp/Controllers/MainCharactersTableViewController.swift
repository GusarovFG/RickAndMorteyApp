//
//  MainCharactersTableViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 03.10.2021.
//

import UIKit

class MainCharactersTableViewController: UITableViewController {

    //MARK: Private properties
    private var rickAndMorty: RickAndMorty?
    private var charactersImages: [UIImage]?
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredChracter: [Character] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60

        fetchData(from: URLS.rickAndMortyapi.rawValue)
        setupSearchController()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredChracter.count : rickAndMorty?.results.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharactersTableViewCell
        let character = isFiltering ? filteredChracter[indexPath.row] : rickAndMorty?.results[indexPath.row]

        cell.configure(with: character)

        return cell
    }



    // MARK: - Private methods
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true

        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .black
        }
    }

    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) {  ricksAndMortys in
            DispatchQueue.main.async {
                self.rickAndMorty = ricksAndMortys
                self.tableView.reloadData()
            }
        }
    }

}

// MARK: - UISearchResultsUpdating
extension MainCharactersTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    private func filterContentForSearchText(_ searchText: String) {
        filteredChracter = rickAndMorty?.results.filter { chracter in
            chracter.name.lowercased().contains(searchText.lowercased())
        } ?? []

        tableView.reloadData()
    }
}


