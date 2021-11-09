//
//  FavoritersLocatiosViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 06.11.2021.
//

import UIKit

class FavoritersLocatiosViewController: UIViewController {

    var locations: [FavoritesLocation] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.tableView.rowHeight = 60
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.locations = CoreDataManager.shared.fetchLocations()
        self.tableView.reloadData()
    }

    // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "LocationSegue" {
             let detailVC = segue.destination as! DetailCharactersTableViewController
             let indexPath = self.tableView.indexPathForSelectedRow
             let lination = self.locations[indexPath?.row ?? 0]
             detailVC.location = Location(name: lination.name ?? "" ,
                                          type: lination.type ?? "",
                                          dimension: lination.dimension ?? "",
                                          residents: lination.residents as? [String] ?? [],
                                          url: lination.url ?? "",
                                          created: lination.created ?? "")

         }
     }

}

extension FavoritersLocatiosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.locations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteLocationCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let location = locations[indexPath.row]
        content.text = location.name
        cell.contentConfiguration = content
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.locations.remove(at: indexPath.row)
            CoreDataManager.shared.deleteLocation(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
