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

        self.locations = CoreDataManager.shared.fetchLocations()
        self.tableView.reloadData()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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


}
