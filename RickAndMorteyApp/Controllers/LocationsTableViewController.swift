//
//  LocationsTableViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 03.11.2021.
//

import UIKit

class LocationsTableViewController: UITableViewController {

    private var locations: Locations?
    private var locationsList: [Location] = []

    private var beginFetch = false

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLocations()
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)
        self.title = "Locations"
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locationsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        var content = cell.defaultContentConfiguration()

        let location = self.locationsList[indexPath.row]

        content.text = location.name
        cell.contentConfiguration = content

        return cell
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offSetY > contentHeight - scrollView.frame.height{
            if !self.beginFetch {
                fetchNextEpisodes()
            }
        }
    }

     // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "locationSegue" {
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            let detailVC = segue.destination as? DetailCharactersTableViewController
            detailVC?.location = locationsList[indexPath.row]
        }
    }

    func fetchLocations() {
        NetworkManager.shared.fetchLocations(from: URLS.locations.rawValue) { [weak self]  result in
            self?.locations = result
            self?.locationsList = result.results
            self?.tableView.reloadData()
        }
    }

    private func fetchNextEpisodes() {
        self.beginFetch = true
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1.0) {
            NetworkManager.shared.fetchLocations(from: self.locations?.info.next) { result in
                self.locations = result
                self.locationsList.append(contentsOf: result.results.compactMap{$0})
                self.tableView.reloadData()
                self.beginFetch = false
            }
        }
    }
}
