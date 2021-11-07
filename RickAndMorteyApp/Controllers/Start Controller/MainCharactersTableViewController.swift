
//  MainCharactersTableViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 03.10.2021.


import UIKit

class MainCharactersTableViewController: UITableViewController{

    //MARK: Private properties

    private var rickAndMorty: RickAndMorty?
    private var characters: [Character] = []
    private var filteredChracter: [Character] = []
    private var beginFetch = false
    private let searchController = UISearchController(searchResultsController: nil)
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
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)
        self.title = "Characters"
        self.navigationController?.navigationBar.tintColor = .white
        tableView.rowHeight = 60
        fetchData()
        setupSearchController()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredChracter.count : characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharactersTableViewCell
        let character = isFiltering ? filteredChracter[indexPath.row] : characters[indexPath.row]

        cell.configure(with: character)

        return cell
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offSetY > contentHeight - scrollView.frame.height, !isFiltering {
            if !beginFetch {
                fetchNextCharacters()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }

            if let detailVC = segue.destination as? DetailCharactersTableViewController {
                let character = isFiltering ? filteredChracter[indexPath.row] : characters[indexPath.row]
                detailVC.character = character
            }
        }
    }


    // MARK: - Private methods
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.backgroundColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)
        searchController.searchBar.tintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true

        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.systemFont(ofSize: 17)
            textField.textColor = .black
            textField.backgroundColor = .white
            textField.tintColor = .black
            
        }
    }


    private func fetchData() {
        NetworkManager.shared.fetchCharacters(from: URLS.rickAndMortyapi.rawValue) {  ricksAndMortys in
            DispatchQueue.main.async {
                self.rickAndMorty = ricksAndMortys
                self.characters = ricksAndMortys.results
                self.tableView.reloadData()
            }
        }
    }

    private func fetchNextCharacters() {
        beginFetch = true
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1.0) {
            NetworkManager.shared.fetchCharacters(from: self.rickAndMorty?.info.next) { ricksAndMorteys in
                
                self.rickAndMorty = ricksAndMorteys
                self.characters.append(contentsOf: ricksAndMorteys.results.compactMap{$0})
                self.tableView.reloadData()
                self.beginFetch = false
            }
        }

    }
    func getImage(_ url: String) -> UIImage {
        var image = UIImage()
        ImageManager.shared.fetchImage(from: url) { data, response in
            DispatchQueue.global().async {
                image = UIImage(data: data) ?? UIImage(systemName: "person")!
            }
        }
        return image
    }

}

// MARK: - UISearchResultsUpdating
extension MainCharactersTableViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    private func filterContentForSearchText(_ searchText: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            NetworkManager.shared.fetchCharacters(from: URLS.filteredCharacter.rawValue + searchText) { result in
                self.filteredChracter = result.results
                print(result)
                self.tableView.reloadData()
            }
        }


    }
}



