
//  MainCharactersTableViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 03.10.2021.


import UIKit

class MainCharactersTableViewController: UITableViewController{

    //MARK: Private properties

    private var rickAndMorty: RickAndMorty?
    private var charactersss: [Character] = []
    private var beginFetch = false
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
        fetchData(URLS.rickAndMortyapi.rawValue)
        setupSearchController()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredChracter.count : charactersss.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharactersTableViewCell
        let character = isFiltering ? filteredChracter[indexPath.row] : charactersss[indexPath.row]

        cell.configure(with: character)

        return cell
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offSetY > contentHeight - scrollView.frame.height {
            if !beginFetch {
                fetchNextCharacters()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }

            if let detailVC = segue.destination as? DetailCharactersTableViewController {
                let character = isFiltering ? filteredChracter[indexPath.row] : charactersss[indexPath.row]
                detailVC.character = character
            }
        }
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


    private func fetchData(_ url: String?) {
        NetworkManager.shared.fetchData(from: url) {  ricksAndMortys in
            DispatchQueue.main.async {
                self.rickAndMorty = ricksAndMortys
                self.charactersss = ricksAndMortys.results
                self.tableView.reloadData()
            }
        }
    }

    private func fetchNextCharacters() {
                beginFetch = true
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2.0) {
            NetworkManager.shared.fetchData(from: self.rickAndMorty?.info.next) { ricksAndMorteys in
                self.rickAndMorty = ricksAndMorteys
                self.charactersss.append(contentsOf: ricksAndMorteys.results.compactMap{$0})
                self.tableView.reloadData()
                self.beginFetch = false
                print(self.charactersss)
            }
        }
    }

    private func fetchEpisodes(_ url: String?) {
        NetworkManager.shared.fetchEpisode(from: url ?? "") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let episode):
                    self.episodes.append(episode)
                case .failure(let error):
                    print(error)

                }
            }
        }
    }
    func getImage(_ url: String) -> UIImage {
        var image = UIImage()
        ImageManager.shared.fetchImage(from: url) { data, response in
            DispatchQueue.global().async {
                image = UIImage(data: data) ?? UIImage(systemName: "eye")!
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
        filteredChracter = charactersss.filter { chracter in
            chracter.name.lowercased().contains(searchText.lowercased())
        }

        tableView.reloadData()
    }
}


extension MainCharactersTableViewController: DetailCharacterDelegate {
    func fetchChar() -> Character {
        let tableViewIndexPath = self.tableView.indexPathForSelectedRow
        guard let character = rickAndMorty?.results[tableViewIndexPath?.row ?? 0] else { return Character(id: 0, name: "", status: "", species: "", gender: "", origin: Location(name: ""), location: Location(name: ""), image: "", episode: [""], url: "", created: "") }
        return character
    }
    
}
