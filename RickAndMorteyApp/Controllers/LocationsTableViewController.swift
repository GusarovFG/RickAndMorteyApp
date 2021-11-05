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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locationsList.count
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
            if !beginFetch {
                fetchNextEpisodes()
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


     // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "locationSegue" {
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            let detailVC = segue.destination as? DetailCharactersTableViewController
            detailVC?.location = locationsList[indexPath.row]
        }
    }

    func fetchLocations() {
        NetworkManager.shared.fetchLocations(from: URLS.locations.rawValue) { result in
            DispatchQueue.main.async {
                self.locations = result
                self.locationsList = result.results
                self.tableView.reloadData()
            }
        }
    }

    private func fetchNextEpisodes() {
        beginFetch = true
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
